import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:itunes_albums/core/ui/ui_gesture_detector.dart';

void main() {
  testWidgets('UIGestureDetector displays its child', (
    WidgetTester tester,
  ) async {
    const childKey = Key('child');
    await tester.pumpWidget(
      MaterialApp(
        home: UIGestureDetector(
          onTap: () {},
          child: const Text('Tap me', key: childKey),
        ),
      ),
    );

    expect(find.byKey(childKey), findsOneWidget);
    expect(find.text('Tap me'), findsOneWidget);
  });

  testWidgets('UIGestureDetector calls onTap when tapped', (
    WidgetTester tester,
  ) async {
    bool tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: UIGestureDetector(
          onTap: () {
            tapped = true;
          },
          child: const Text('Tap me'),
        ),
      ),
    );

    await tester.tap(find.text('Tap me'));
    await tester.pump();

    expect(tapped, isTrue);
  });

  testWidgets('UIGestureDetector has transparent Container', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: UIGestureDetector(onTap: () {}, child: const Text('Child')),
      ),
    );

    final container = tester.widget<Container>(find.byType(Container).first);

    expect(container.color, Colors.transparent);
  });
}
