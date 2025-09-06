import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:itunes_albums/core/ui/ui_text.dart';

void main() {
  testWidgets('UIText displays the given text', (WidgetTester tester) async {
    const testText = 'Hello Flutter';

    await tester.pumpWidget(const MaterialApp(home: UIText(testText)));

    expect(find.text(testText), findsOneWidget);
  });

  testWidgets('UIText applies correct text style', (WidgetTester tester) async {
    const testText = 'Styled Text';

    await tester.pumpWidget(const MaterialApp(home: UIText(testText)));

    final textWidget = tester.widget<Text>(find.text(testText));

    expect(textWidget.style?.color, Colors.black);
    expect(textWidget.style?.fontWeight, FontWeight.w500);
    expect(textWidget.style?.fontSize, 12);
    expect(textWidget.style?.fontFamily, 'Poppins');
    expect(textWidget.maxLines, 1);
    expect(textWidget.overflow, TextOverflow.ellipsis);
  });
}
