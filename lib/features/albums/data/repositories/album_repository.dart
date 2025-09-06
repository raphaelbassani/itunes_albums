import 'package:dart_either/dart_either.dart';

import '../datasources/album_remote_datasource.dart';
import '../errors/exceptions.dart';
import '../errors/failures.dart';
import '../models/album_model.dart';

class AlbumRepository {
  final AlbumRemoteDatasource remoteDatasource;

  AlbumRepository({required this.remoteDatasource});

  Future<Either<Failure, List<AlbumModel>>> getTopAlbums() async {
    Failure? failure;
    try {
      final response = await remoteDatasource.fetchTopAlbums();

      return Right(response);
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
}
