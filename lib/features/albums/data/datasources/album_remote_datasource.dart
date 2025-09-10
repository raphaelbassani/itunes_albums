import 'dart:io';

import 'package:dio/dio.dart';

import '../errors/exceptions.dart';

class AlbumRemoteDatasource {
  final Dio dio;

  AlbumRemoteDatasource({required this.dio});

  static const _baseUrl =
      'https://itunes.apple.com/us/rss/topalbums/limit=100/json';

  Future<String> fetchTopAlbums() async {
    try {
      final response = await dio.get(_baseUrl);

      if (response.statusCode == HttpStatus.ok) {
        if (response.data is String) {
          return response.data;
        } else {
          throw UnknownException('Invalid response format');
        }
      } else {
        _handleStatusCode(response.statusCode);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode != null) {
        _handleStatusCode(e.response!.statusCode);
      } else {
        throw UnknownException(e.message ?? 'Dio error');
      }
    } catch (e) {
      throw UnknownException(e.toString());
    }

    throw UnknownException('Unhandled error');
  }

  void _handleStatusCode(int? statusCode) {
    if (statusCode == null) {
      throw UnknownException('No status code received');
    } else if (statusCode == HttpStatus.notFound) {
      throw NotFoundException('Resource not found');
    } else if (statusCode >= HttpStatus.internalServerError) {
      throw ServerException('Server error with code $statusCode');
    } else {
      throw UnknownException('Unhandled status code $statusCode');
    }
  }
}
