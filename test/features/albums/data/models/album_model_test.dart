import 'package:flutter_test/flutter_test.dart';
import 'package:itunes_albums/features/albums/data/models/album_model.dart';

void main() {
  group('AlbumModel', () {
    final json = {
      'im:name': {'label': 'Test Album'},
      'im:artist': {'label': 'Test Artist'},
      'im:image': [
        {'label': 'small.jpg'},
        {'label': 'medium.jpg'},
        {'label': 'large.jpg'},
      ],
      'im:releaseDate': {'label': '2023-01-15T00:00:00-07:00'},
      'category': {
        'attributes': {'label': 'Pop'},
      },
      'im:itemCount': {'label': '12'},
    };

    test('should create AlbumModel from JSON', () {
      // act
      final album = AlbumModel.fromJson(json);

      // assert
      expect(album.artUrl, 'large.jpg');
      expect(album.name, 'Test Album');
      expect(album.artistName, 'Test Artist');
      expect(album.releaseDate, DateTime.parse('2023-01-15T00:00:00-07:00'));
      expect(album.genre, 'Pop');
      expect(album.trackCount, 12);
    });

    test('should handle missing optional fields gracefully', () {
      final incompleteJson = {
        'im:name': {'label': 'Album'},
        'im:artist': {'label': 'Artist'},
        'im:image': [],
      };

      final album = AlbumModel.fromJson(incompleteJson);

      expect(album.artUrl, '');
      expect(album.name, 'Album');
      expect(album.artistName, 'Artist');
      expect(album.releaseDate, null);
      expect(album.genre, null);
      expect(album.trackCount, null);
    });

    test('formattedReleaseDate should return correct format', () {
      final album = AlbumModel(
        artUrl: 'url',
        name: 'Album',
        artistName: 'Artist',
        releaseDate: DateTime(2023, 2, 5),
        genre: 'Pop',
        trackCount: 10,
      );

      expect(album.formattedReleaseDate, '05/02/2023');
    });

    test('formattedReleaseDate should return null if releaseDate is null', () {
      final album = const AlbumModel(
        artUrl: 'url',
        name: 'Album',
        artistName: 'Artist',
        releaseDate: null,
        genre: 'Pop',
        trackCount: 10,
      );

      expect(album.formattedReleaseDate, null);
    });

    test('formattedTrackCount should return string when trackCount > 0', () {
      final album = AlbumModel(
        artUrl: 'url',
        name: 'Album',
        artistName: 'Artist',
        releaseDate: DateTime.now(),
        genre: 'Pop',
        trackCount: 5,
      );

      expect(album.formattedTrackCount, '5');
    });

    test(
      'formattedTrackCount should return null when trackCount is null or 0',
      () {
        final album1 = AlbumModel(
          artUrl: 'url',
          name: 'Album',
          artistName: 'Artist',
          releaseDate: DateTime.now(),
          genre: 'Pop',
          trackCount: 0,
        );

        final album2 = AlbumModel(
          artUrl: 'url',
          name: 'Album',
          artistName: 'Artist',
          releaseDate: DateTime.now(),
          genre: 'Pop',
          trackCount: null,
        );

        expect(album1.formattedTrackCount, null);
        expect(album2.formattedTrackCount, null);
      },
    );

    test('props should allow equality comparison', () {
      final album1 = AlbumModel(
        artUrl: 'url',
        name: 'Album',
        artistName: 'Artist',
        releaseDate: DateTime(2023, 1, 1),
        genre: 'Pop',
        trackCount: 10,
      );

      final album2 = AlbumModel(
        artUrl: 'url',
        name: 'Album',
        artistName: 'Artist',
        releaseDate: DateTime(2023, 1, 1),
        genre: 'Pop',
        trackCount: 10,
      );

      expect(album1, album2);
    });
  });
}
