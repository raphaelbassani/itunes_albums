import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:itunes_albums/core/ui/ui_title.dart';

void main() {
  testWidgets('UITitle displays the given text', (WidgetTester tester) async {
    const testText = 'My Title';

    await tester.pumpWidget(const MaterialApp(home: UITitle(testText)));

    expect(find.text(testText), findsOneWidget);
  });

  testWidgets('UITitle applies default style when color is not provided', (
    WidgetTester tester,
  ) async {
    const testText = 'Default Color';

    await tester.pumpWidget(const MaterialApp(home: UITitle(testText)));

    final textWidget = tester.widget<Text>(find.text(testText));

    expect(textWidget.style?.color, Colors.black);
    expect(textWidget.style?.fontWeight, FontWeight.bold);
    expect(textWidget.style?.fontSize, 14);
    expect(textWidget.style?.fontFamily, 'Poppins');
    expect(textWidget.maxLines, 1);
    expect(textWidget.overflow, TextOverflow.ellipsis);
  });

  testWidgets('UITitle applies custom color when provided', (
    WidgetTester tester,
  ) async {
    const testText = 'Custom Color';
    const customColor = Colors.red;

    await tester.pumpWidget(
      const MaterialApp(home: UITitle(testText, color: customColor)),
    );

    final textWidget = tester.widget<Text>(find.text(testText));

    expect(textWidget.style?.color, customColor);
  });
}
