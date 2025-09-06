import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:itunes_albums/core/extensions/context_extension.dart';

void main() {
  testWidgets('ContextExtension should return correct width and height', (
    WidgetTester tester,
  ) async {
    const testWidth = 400.0;
    const testHeight = 800.0;

    await tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(size: Size(testWidth, testHeight)),
          child: Builder(
            builder: (context) {
              expect(context.width, testWidth);
              expect(context.height, testHeight);
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  });
}
