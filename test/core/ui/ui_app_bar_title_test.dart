import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:itunes_albums/core/ui/ui_app_bar_title.dart';

void main() {
  testWidgets('UIAppBarTitle displays given text', (tester) async {
    // Arrange
    const text = 'Hello Flutter';

    // Build do widget
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: UIAppBarTitle(text))),
    );

    // Act & Assert
    expect(find.text(text), findsOneWidget);
  });

  testWidgets('UIAppBarTitle uses correct text style', (tester) async {
    const text = 'Test Title';

    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: UIAppBarTitle(text))),
    );

    final textWidget = tester.widget<Text>(find.text(text));

    expect(textWidget.style?.color, Colors.black);
    expect(textWidget.style?.fontWeight, FontWeight.bold);
    expect(textWidget.style?.fontSize, 18);
    expect(textWidget.style?.fontFamily, 'Poppins');
  });

  testWidgets('UIAppBarTitle respects maxLines and overflow', (tester) async {
    const text = 'Line1\nLine2\nLine3\nLine4\nLine5\nLine6';

    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: UIAppBarTitle(text))),
    );

    final textWidget = tester.widget<Text>(find.textContaining('Line1'));

    expect(textWidget.maxLines, 5);
    expect(textWidget.overflow, TextOverflow.ellipsis);
  });
}
