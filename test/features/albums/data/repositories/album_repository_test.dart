import 'package:flutter_test/flutter_test.dart';
import 'package:itunes_albums/features/albums/data/datasources/album_remote_datasource.dart';
import 'package:itunes_albums/features/albums/data/errors/exceptions.dart';
import 'package:itunes_albums/features/albums/data/errors/failures.dart';
import 'package:itunes_albums/features/albums/data/models/album_model.dart';
import 'package:itunes_albums/features/albums/data/repositories/album_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockAlbumRemoteDatasource extends Mock implements AlbumRemoteDatasource {}

void main() {
  late AlbumRepository repository;
  late MockAlbumRemoteDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockAlbumRemoteDatasource();
    repository = AlbumRepository(remoteDatasource: mockDatasource);
  });

  final albumList = [
    AlbumModel(
      artUrl: 'url1',
      name: 'Album 1',
      artistName: 'Artist 1',
      releaseDate: DateTime.parse('2023-01-01'),
      genre: 'Pop',
      trackCount: 10,
    ),
    AlbumModel(
      artUrl: 'url2',
      name: 'Album 2',
      artistName: 'Artist 2',
      releaseDate: DateTime.parse('2022-12-01'),
      genre: 'Rock',
      trackCount: 12,
    ),
  ];

  test(
    'should return Right<List<AlbumModel>> when datasource succeeds',
    () async {
      when(
        () => mockDatasource.fetchTopAlbums(),
      ).thenAnswer((_) async => albumList);

      final result = await repository.getTopAlbums();

      expect(result.isRight, true);
      result.fold(
        ifLeft: (_) => fail('Expected Right but got Left'),
        ifRight: (r) => expect(r, albumList),
      );
    },
  );

  test(
    'should return Left<NotFoundFailure> when datasource throws NotFoundException',
    () async {
      when(
        () => mockDatasource.fetchTopAlbums(),
      ).thenThrow(NotFoundException('Resource not found'));

      final result = await repository.getTopAlbums();

      expect(result.isLeft, true);
      result.fold(
        ifLeft: (l) {
          expect(l, isA<NotFoundFailure>());
          expect(l.message, 'Resource not found');
        },
        ifRight: (_) => fail('Expected Left but got Right'),
      );
    },
  );

  test(
    'should return Left<ServerFailure> when datasource throws ServerException',
    () async {
      when(
        () => mockDatasource.fetchTopAlbums(),
      ).thenThrow(ServerException('Server error'));

      final result = await repository.getTopAlbums();

      expect(result.isLeft, true);
      result.fold(
        ifLeft: (l) {
          expect(l, isA<ServerFailure>());
          expect(l.message, 'Server error');
        },
        ifRight: (_) => fail('Expected Left but got Right'),
      );
    },
  );

  test(
    'should return Left<UnknownFailure> when datasource throws UnknownException',
    () async {
      when(
        () => mockDatasource.fetchTopAlbums(),
      ).thenThrow(UnknownException('Unknown error'));

      final result = await repository.getTopAlbums();

      expect(result.isLeft, true);
      result.fold(
        ifLeft: (l) {
          expect(l, isA<UnknownFailure>());
          expect(l.message, 'Unknown error');
        },
        ifRight: (_) => fail('Expected Left but got Right'),
      );
    },
  );

  test(
    'should return Left<UnknownFailure> when datasource throws generic exception',
    () async {
      when(
        () => mockDatasource.fetchTopAlbums(),
      ).thenThrow(Exception('Generic error'));

      final result = await repository.getTopAlbums();

      expect(result.isLeft, true);
      result.fold(
        ifLeft: (l) {
          expect(l, isA<UnknownFailure>());
          expect(l.message, 'Exception: Generic error');
        },
        ifRight: (_) => fail('Expected Left but got Right'),
      );
    },
  );
}
