import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:itunes_albums/features/albums/data/datasources/album_remote_datasource.dart';
import 'package:itunes_albums/features/albums/data/errors/exceptions.dart';
import 'package:itunes_albums/features/albums/data/models/album_model.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late AlbumRemoteDatasource datasource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    datasource = AlbumRemoteDatasource(dio: mockDio);
  });

  group('fetchTopAlbums', () {
    final jsonResponse = {
      'feed': {
        'entry': [
          {
            'im:name': {'label': 'Album 1'},
            'im:artist': {'label': 'Artist 1'},
            'im:image': [
              {'label': 'small.jpg'},
              {'label': 'medium.jpg'},
              {'label': 'large.jpg'},
            ],
            'im:releaseDate': {'label': '2023-01-01T00:00:00-07:00'},
            'category': {
              'attributes': {'label': 'Pop'},
            },
            'im:itemCount': {'label': '12'},
          },
          {
            'im:name': {'label': 'Album 2'},
            'im:artist': {'label': 'Artist 2'},
            'im:image': [
              {'label': 'small2.jpg'},
              {'label': 'medium2.jpg'},
              {'label': 'large2.jpg'},
            ],
            'im:releaseDate': {'label': '2022-12-01T00:00:00-07:00'},
            'category': {
              'attributes': {'label': 'Rock'},
            },
            'im:itemCount': {'label': '10'},
          },
        ],
      },
    };

    final albumList = [
      AlbumModel(
        artUrl: 'large.jpg',
        name: 'Album 1',
        artistName: 'Artist 1',
        releaseDate: DateTime.parse('2023-01-01T00:00:00-07:00'),
        genre: 'Pop',
        trackCount: 12,
      ),
      AlbumModel(
        artUrl: 'large2.jpg',
        name: 'Album 2',
        artistName: 'Artist 2',
        releaseDate: DateTime.parse('2022-12-01T00:00:00-07:00'),
        genre: 'Rock',
        trackCount: 10,
      ),
    ];

    test('should return list of AlbumModel when response is 200', () async {
      // arrange
      when(() => mockDio.get(any())).thenAnswer(
        (_) async => Response(
          data: jsonResponse,
          statusCode: HttpStatus.ok,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      // act
      final result = await datasource.fetchTopAlbums();

      // assert
      expect(result, albumList);
    });

    test('should throw NotFoundException when status code is 404', () async {
      // arrange
      when(() => mockDio.get(any())).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
            statusCode: HttpStatus.notFound,
            requestOptions: RequestOptions(path: ''),
          ),
        ),
      );

      // act
      final call = datasource.fetchTopAlbums();

      // assert
      expect(() => call, throwsA(isA<NotFoundException>()));
    });

    test('should throw ServerException when status code >= 500', () async {
      // arrange
      when(() => mockDio.get(any())).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
            statusCode: HttpStatus.internalServerError,
            requestOptions: RequestOptions(path: ''),
          ),
        ),
      );

      // act
      final call = datasource.fetchTopAlbums();

      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });

    test(
      'should throw UnknownException on Dio error without response',
      () async {
        // arrange
        when(() => mockDio.get(any())).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ''),
            message: 'Connection failed',
          ),
        );

        // act
        final call = datasource.fetchTopAlbums();

        // assert
        expect(() => call, throwsA(isA<UnknownException>()));
      },
    );

    test('should throw UnknownException on invalid JSON structure', () async {
      // arrange
      when(() => mockDio.get(any())).thenAnswer(
        (_) async => Response(
          data: {'invalid': 'data'},
          statusCode: HttpStatus.ok,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      // act
      final call = datasource.fetchTopAlbums();

      // assert
      expect(() => call, throwsA(isA<UnknownException>()));
    });
  });
}
