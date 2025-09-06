import 'package:flutter_test/flutter_test.dart';
import 'package:itunes_albums/core/enums/view_model_status.dart';
import 'package:itunes_albums/features/albums/data/errors/failures.dart';
import 'package:itunes_albums/features/albums/data/models/album_model.dart';
import 'package:itunes_albums/features/albums/data/models/album_state.dart';

void main() {
  group('AlbumState', () {
    test('should have correct default values', () {
      final state = const AlbumState();

      expect(state.status, ViewModelStatus.idle);
      expect(state.albums, []);
      expect(state.failure, null);
    });

    test('copyWith should update status', () {
      final state = const AlbumState();
      final newState = state.copyWith(status: ViewModelStatus.loading);

      expect(newState.status, ViewModelStatus.loading);
      expect(newState.albums, state.albums);
      expect(newState.failure, state.failure);
    });

    test('copyWith should update albums', () {
      final albums = [
        const AlbumModel(
          artUrl: 'url1',
          name: 'Album 1',
          artistName: 'Artist 1',
          releaseDate: null,
          genre: 'Pop',
          trackCount: 10,
        ),
      ];

      final state = const AlbumState();
      final newState = state.copyWith(albums: albums);

      expect(newState.albums, albums);
      expect(newState.status, state.status);
      expect(newState.failure, state.failure);
    });

    test('copyWith should update failure', () {
      final failure = const UnknownFailure('Error');

      final state = const AlbumState();
      final newState = state.copyWith(failure: failure);

      expect(newState.failure, failure);
      expect(newState.status, state.status);
      expect(newState.albums, state.albums);
    });

    test('copyWith should update multiple fields', () {
      final albums = [
        const AlbumModel(
          artUrl: 'url1',
          name: 'Album 1',
          artistName: 'Artist 1',
          releaseDate: null,
          genre: 'Pop',
          trackCount: 10,
        ),
      ];
      final failure = const UnknownFailure('Error');

      final state = const AlbumState();
      final newState = state.copyWith(
        status: ViewModelStatus.success,
        albums: albums,
        failure: failure,
      );

      expect(newState.status, ViewModelStatus.success);
      expect(newState.albums, albums);
      expect(newState.failure, failure);
    });

    test('props should allow equality comparison', () {
      final state1 = const AlbumState();
      final state2 = const AlbumState();

      expect(state1, state2);
    });
  });
}
