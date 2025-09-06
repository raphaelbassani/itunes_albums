import 'package:riverpod/riverpod.dart';

import '../../../../core/enums/view_model_status.dart';
import '../../data/models/album_state.dart';
import '../../data/repositories/album_repository.dart';

class AlbumViewModel extends StateNotifier<AlbumState> {
  final AlbumRepository repository;

  AlbumViewModel({required this.repository}) : super(const AlbumState());

  Future<void> fetchTopAlbums() async {
    state = state.copyWith(status: ViewModelStatus.loading, failure: null);

    final result = await repository.getTopAlbums();

    result.fold(
      ifLeft: (failure) {
        state = state.copyWith(
          status: ViewModelStatus.failure,
          failure: failure,
        );
      },
      ifRight: (albums) {
        state = state.copyWith(status: ViewModelStatus.success, albums: albums);
      },
    );
  }
}
