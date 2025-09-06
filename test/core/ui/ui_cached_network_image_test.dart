import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:itunes_albums/core/ui/ui_cached_network_image.dart';

void main() {
  testWidgets('UICachedNetworkImage displays placeholder initially', (
    tester,
  ) async {
    const imageUrl = 'https://example.com/image.png';

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: UICachedNetworkImage(
            imageUrl: imageUrl,
            height: 100,
            width: 100,
          ),
        ),
      ),
    );

    expect(find.byType(CachedNetworkImage), findsOneWidget);

    final placeholderContainer = tester.widget<Container>(
      find.byType(Container).first,
    );
    expect(placeholderContainer.color, Colors.grey[300]);
    expect(placeholderContainer.constraints?.maxHeight, 100);
  });

  testWidgets('UICachedNetworkImage displays error widget on failed load', (
    tester,
  ) async {
    const imageUrl = 'https://example.com/invalid_image.png';

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: UICachedNetworkImage(imageUrl: imageUrl, height: 80, width: 80),
        ),
      ),
    );

    final errorWidgetBuilder = tester
        .widget<CachedNetworkImage>(find.byType(CachedNetworkImage))
        .errorWidget;

    final errorWidget = errorWidgetBuilder?.call(
      tester.element(find.byType(CachedNetworkImage)),
      imageUrl,
      Exception('Failed to load image'),
    );

    expect(errorWidget, isA<Container>());

    final container = errorWidget as Container;
    expect(container.color, Colors.grey);
  });

  testWidgets(
    'UICachedNetworkImage uses default height and width when not set',
    (tester) async {
      const imageUrl = 'https://example.com/image.png';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: UICachedNetworkImage(imageUrl: imageUrl)),
        ),
      );

      final cachedImage = tester.widget<CachedNetworkImage>(
        find.byType(CachedNetworkImage),
      );

      expect(cachedImage.height, 60);
      expect(cachedImage.width, 60);
    },
  );
}
