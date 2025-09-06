import 'package:dart_either/dart_either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:itunes_albums/core/enums/view_model_status.dart';
import 'package:itunes_albums/features/albums/data/errors/failures.dart';
import 'package:itunes_albums/features/albums/data/models/album_model.dart';
import 'package:itunes_albums/features/albums/data/repositories/album_repository.dart';
import 'package:itunes_albums/features/albums/presentation/viewmodels/album_viewmodel.dart';
import 'package:mocktail/mocktail.dart';

class MockAlbumRepository extends Mock implements AlbumRepository {}

void main() {
  late MockAlbumRepository mockRepository;
  late AlbumViewModel viewModel;

  setUp(() {
    mockRepository = MockAlbumRepository();
    viewModel = AlbumViewModel(repository: mockRepository);
  });

  final albumList = [
    AlbumModel(
      artUrl: 'url1',
      name: 'Album 1',
      artistName: 'Artist 1',
      releaseDate: DateTime(2023, 1, 1),
      genre: 'Pop',
      trackCount: 10,
    ),
    AlbumModel(
      artUrl: 'url2',
      name: 'Album 2',
      artistName: 'Artist 2',
      releaseDate: DateTime(2022, 12, 1),
      genre: 'Rock',
      trackCount: 12,
    ),
  ];

  test('initial state should be idle with empty albums and no failure', () {
    expect(viewModel.state.status, ViewModelStatus.idle);
    expect(viewModel.state.albums, []);
    expect(viewModel.state.failure, null);
  });

  test('fetchTopAlbums should set status to loading first', () async {
    when(
      () => mockRepository.getTopAlbums(),
    ).thenAnswer((_) async => Right(albumList));

    final future = viewModel.fetchTopAlbums();

    expect(viewModel.state.status, ViewModelStatus.loading);

    await future;
  });

  test(
    'fetchTopAlbums should set status to success and update albums on success',
    () async {
      when(
        () => mockRepository.getTopAlbums(),
      ).thenAnswer((_) async => Right(albumList));

      await viewModel.fetchTopAlbums();

      expect(viewModel.state.status, ViewModelStatus.success);
      expect(viewModel.state.albums, albumList);
      expect(viewModel.state.failure, null);
    },
  );

  test(
    'fetchTopAlbums should set status to failure and update failure on error',
    () async {
      final failure = const UnknownFailure('Failed to fetch');
      when(
        () => mockRepository.getTopAlbums(),
      ).thenAnswer((_) async => Left(failure));

      await viewModel.fetchTopAlbums();

      expect(viewModel.state.status, ViewModelStatus.failure);
      expect(viewModel.state.failure, failure);
      expect(viewModel.state.albums, []);
    },
  );
}
