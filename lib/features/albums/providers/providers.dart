import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/datasources/album_local_datasource.dart';
import '../data/datasources/album_remote_datasource.dart';
import '../data/models/album_state.dart';
import '../data/repositories/album_repository.dart';
import '../presentation/viewmodels/album_viewmodel.dart';

final dioProvider = Provider<Dio>((ref) => Dio());

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((
  ref,
) async {
  return await SharedPreferences.getInstance();
});

final albumLocalDataSourceProvider = FutureProvider<AlbumLocalDatasource>((
  ref,
) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  return AlbumLocalDatasource(localStorage: prefs);
});

final albumRemoteDataSourceProvider = Provider<AlbumRemoteDatasource>((ref) {
  final dio = ref.watch(dioProvider);
  return AlbumRemoteDatasource(dio: dio);
});

final albumRepositoryProvider = Provider<AlbumRepository>((ref) {
  final dataSource = ref.watch(albumRemoteDataSourceProvider);
  final localDatasource = ref.watch(albumLocalDataSourceProvider.future);
  return AlbumRepository(
    remoteDatasource: dataSource,
    localDatasource: localDatasource,
  );
});

final albumViewModelProvider =
    StateNotifierProvider<AlbumViewModel, AlbumState>((ref) {
      final repository = ref.watch(albumRepositoryProvider);
      return AlbumViewModel(repository: repository);
    });
