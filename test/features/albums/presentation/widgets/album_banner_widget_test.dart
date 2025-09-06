import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:itunes_albums/core/ui/ui_cached_network_image.dart';
import 'package:itunes_albums/core/ui/ui_text.dart';
import 'package:itunes_albums/core/ui/ui_title.dart';
import 'package:itunes_albums/features/albums/data/models/album_model.dart';
import 'package:itunes_albums/features/albums/presentation/widgets/album_banner_widget.dart';

void main() {
  late AlbumModel album;

  setUp(() {
    album = AlbumModel(
      artUrl: 'https://example.com/image.jpg',
      name: 'Test Album',
      artistName: 'Test Artist',
      releaseDate: DateTime(2023, 1, 1),
      genre: 'Pop',
      trackCount: 10,
    );
  });

  testWidgets('renders album title, artist and image', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AlbumBannerWidget(album: album, onSelected: (_) {}),
      ),
    );

    expect(find.byType(UITitle), findsOneWidget);
    expect(find.text('Test Album'), findsOneWidget);

    expect(find.byType(UIText), findsOneWidget);
    expect(find.text('Test Artist'), findsOneWidget);

    expect(find.byType(UICachedNetworkImage), findsOneWidget);
  });

  testWidgets('calls onSelected when tapped', (tester) async {
    AlbumModel? selectedAlbum;

    await tester.pumpWidget(
      MaterialApp(
        home: AlbumBannerWidget(
          album: album,
          onSelected: (a) => selectedAlbum = a,
        ),
      ),
    );

    await tester.tap(find.byType(AlbumBannerWidget));
    await tester.pumpAndSettle();

    expect(selectedAlbum, equals(album));
  });

  testWidgets('contains a Hero widget with correct tag', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AlbumBannerWidget(album: album, onSelected: (_) {}),
      ),
    );

    final heroFinder = find.byType(Hero);
    expect(heroFinder, findsOneWidget);

    final hero = tester.widget<Hero>(heroFinder);
    expect(hero.tag, '${album.name}-img');
  });
}
