import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:itunes_albums/core/ui/ui_subtitle.dart';

void main() {
  testWidgets('UISubtitle displays correct text', (WidgetTester tester) async {
    const text = 'My subtitle';

    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: UISubtitle(text))),
    );

    expect(find.text(text), findsOneWidget);
  });

  testWidgets('UISubtitle has correct style', (WidgetTester tester) async {
    const text = 'Subtitle style test';

    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: UISubtitle(text))),
    );

    final textWidget = tester.widget<Text>(find.text(text));

    expect(textWidget.style?.color, Colors.black54);
    expect(textWidget.style?.fontWeight, FontWeight.w500);
    expect(textWidget.style?.fontSize, 12);
    expect(textWidget.style?.fontFamily, 'Poppins');
  });

  testWidgets('UISubtitle maxLines and overflow', (WidgetTester tester) async {
    const text = 'A very long subtitle that should be truncated if necessary';

    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: UISubtitle(text))),
    );

    final textWidget = tester.widget<Text>(find.text(text));
    expect(textWidget.maxLines, 1);
    expect(textWidget.overflow, TextOverflow.ellipsis);
  });
}
