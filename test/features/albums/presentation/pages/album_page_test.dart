import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:itunes_albums/core/ui/ui_cached_network_image.dart';
import 'package:itunes_albums/features/albums/data/models/album_model.dart';
import 'package:itunes_albums/features/albums/presentation/pages/album_page.dart';

void main() {
  late List<AlbumModel> albums;

  setUp(() {
    albums = [
      AlbumModel(
        artUrl: 'https://example.com/album1.jpg',
        name: 'Album 1',
        artistName: 'Artist 1',
        releaseDate: DateTime(2023, 1, 1),
        genre: 'Pop',
        trackCount: 10,
      ),
      AlbumModel(
        artUrl: 'https://example.com/album2.jpg',
        name: 'Album 2',
        artistName: 'Artist 2',
        releaseDate: DateTime(2022, 12, 1),
        genre: 'Rock',
        trackCount: 12,
      ),
    ];
  });

  testWidgets('renders initial album', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: AlbumPage(albumList: albums, selectedIndex: 0)),
    );

    expect(find.text('Album 1'), findsOneWidget);
    expect(find.text('Artist 1'), findsOneWidget);

    expect(find.byType(Hero), findsOneWidget);
    expect(find.byType(UICachedNetworkImage), findsOneWidget);

    expect(find.text('Release date: 01/01/2023'), findsOneWidget);
    expect(find.text('Genre: Pop'), findsOneWidget);
    expect(find.text('Tracks: 10'), findsOneWidget);
  });

  testWidgets('next button navigates to next album', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: AlbumPage(albumList: albums, selectedIndex: 0)),
    );

    final nextButton = find.byIcon(Icons.arrow_forward_ios);
    expect(nextButton, findsOneWidget);

    await tester.tap(nextButton);
    await tester.pumpAndSettle();

    expect(find.text('Album 2'), findsOneWidget);
    expect(find.text('Artist 2'), findsOneWidget);
    expect(find.text('Release date: 01/12/2022'), findsOneWidget);
    expect(find.text('Genre: Rock'), findsOneWidget);
    expect(find.text('Tracks: 12'), findsOneWidget);
  });

  testWidgets('previous button navigates to previous album', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: AlbumPage(albumList: albums, selectedIndex: 1)),
    );

    final prevButton = find.byIcon(Icons.arrow_back_ios);
    expect(prevButton, findsOneWidget);

    await tester.tap(prevButton);
    await tester.pumpAndSettle();

    expect(find.text('Album 1'), findsOneWidget);
    expect(find.text('Artist 1'), findsOneWidget);
  });
}
