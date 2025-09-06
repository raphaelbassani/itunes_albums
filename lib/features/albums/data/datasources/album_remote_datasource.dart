import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../errors/exceptions.dart';
import '../models/album_model.dart';

class AlbumRemoteDatasource {
  final Dio dio;

  AlbumRemoteDatasource({required this.dio});

  static const _baseUrl =
      'https://itunes.apple.com/us/rss/topalbums/limit=100/json';

  Future<List<AlbumModel>> fetchTopAlbums() async {
    try {
      final response = await dio.get(_baseUrl);

      if (response.statusCode == HttpStatus.ok) {
        final data = response.data is String
            ? jsonDecode(response.data)
            : response.data;

        if (data is Map<String, dynamic> && data['feed']?['entry'] is List) {
          final List entries = data['feed']?['entry'] ?? [];
          return entries
              .map((e) => AlbumModel.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          throw UnknownException('Invalid response format');
        }
      } else if (response.statusCode == HttpStatus.notFound) {
        throw NotFoundException('Resource not found');
      } else if (response.statusCode != null &&
          response.statusCode! >= HttpStatus.internalServerError) {
        throw ServerException('Server error with code ${response.statusCode}');
      } else {
        throw UnknownException('Unhandled error code ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == HttpStatus.notFound) {
        throw NotFoundException();
      } else if (e.response?.statusCode != null &&
          e.response!.statusCode! >= HttpStatus.internalServerError) {
        throw ServerException();
      } else {
        throw UnknownException(e.message ?? 'Dio error');
      }
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }
}
