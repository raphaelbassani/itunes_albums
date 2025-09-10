import 'dart:convert';

import 'package:dart_either/dart_either.dart';

import '../datasources/album_local_datasource.dart';
import '../datasources/album_remote_datasource.dart';
import '../errors/exceptions.dart';
import '../errors/failures.dart';
import '../models/album_model.dart';

class AlbumRepository {
  final AlbumRemoteDatasource remoteDatasource;
  final Future<AlbumLocalDatasource> localDatasource;

  AlbumRepository({
    required this.remoteDatasource,
    required this.localDatasource,
  });

  Future<Either<Failure, List<AlbumModel>>> getTopAlbums() async {
    Failure? failure;
    try {
      final local = await localDatasource;
      final String? localResponse = local.readLocalData();

      if (localResponse != null) {
        return parseAlbums(localResponse);
      }

      final response = await remoteDatasource.fetchTopAlbums();

      local.writeLocalData(response);

      return parseAlbums(response);
    } on NotFoundException catch (e) {
      failure = NotFoundFailure(e.message);
    } on ServerException catch (e) {
      failure = ServerFailure(e.message);
    } on UnknownException catch (e) {
      failure = UnknownFailure(e.message);
    } catch (e) {
      failure = UnknownFailure(e.toString());
    }

    return Left(failure);
  }

  Either<Failure, List<AlbumModel>> parseAlbums(String albums) {
    final data = jsonDecode(albums);

    if (data is Map<String, dynamic> && data['feed']?['entry'] is List) {
      final List entries = data['feed']?['entry'] ?? [];
      return Right(
        entries
            .map((e) => AlbumModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    }

    return const Left(ParseFailure());
  }
}
