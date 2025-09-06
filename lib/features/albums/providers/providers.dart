import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';

import '../data/datasources/album_remote_datasource.dart';
import '../data/repositories/album_repository.dart';
import '../domain/entities/album_state.dart';
import '../presentation/viewmodels/album_viewmodel.dart';

final dioProvider = Provider<Dio>((ref) => Dio());

final albumRemoteDataSourceProvider = Provider<AlbumRemoteDatasource>((ref) {
  final dio = ref.watch(dioProvider);
  return AlbumRemoteDatasource(dio: dio);
});

final albumRepositoryProvider = Provider<AlbumRepository>((ref) {
  final dataSource = ref.watch(albumRemoteDataSourceProvider);
  return AlbumRepository(remoteDatasource: dataSource);
});

final albumViewModelProvider =
    StateNotifierProvider<AlbumViewModel, AlbumState>((ref) {
      final repository = ref.watch(albumRepositoryProvider);
      return AlbumViewModel(repository: repository);
    });
