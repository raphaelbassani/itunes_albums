import 'package:dart_either/dart_either.dart';

import '../../domain/entities/album_model.dart';
import '../datasources/album_remote_datasource.dart';
import '../errors/exceptions.dart';
import '../errors/failures.dart';

class AlbumRepository {
  final AlbumRemoteDatasource remoteDatasource;

  AlbumRepository({required this.remoteDatasource});

  Future<Either<Failure, List<AlbumModel>>> getTopAlbums() async {
    try {
      final response = await remoteDatasource.fetchTopAlbums();

      return Right(response);
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on UnknownException catch (e) {
      return Left(UnknownFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
