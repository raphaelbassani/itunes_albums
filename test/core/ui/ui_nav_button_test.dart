import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:itunes_albums/core/ui/enums/ui_nav_button_state.dart';
import 'package:itunes_albums/core/ui/ui_nav_button.dart';

void main() {
  testWidgets('UINavButton displays icon correctly', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: UINavButton(icon: Icons.arrow_forward_ios, onPressed: () {}),
        ),
      ),
    );

    expect(find.byIcon(Icons.arrow_forward_ios), findsOneWidget);
  });

  testWidgets('UINavButton enabled calls onPressed', (tester) async {
    bool pressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: UINavButton(
            icon: Icons.add,
            state: UINavButtonState.enabled,
            onPressed: () {
              pressed = true;
            },
          ),
        ),
      ),
    );

    final button = tester.widget<TextButton>(find.byType(TextButton));
    final color = button.style!.backgroundColor!.resolve({});

    expect(color, equals(Colors.black));

    await tester.tap(find.byType(UINavButton));
    expect(pressed, isTrue);
  });

  testWidgets('UINavButton disabled does not call onPressed', (tester) async {
    bool pressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: UINavButton(
            icon: Icons.remove,
            state: UINavButtonState.disabled,
            onPressed: () {
              pressed = true;
            },
          ),
        ),
      ),
    );

    final button = tester.widget<TextButton>(find.byType(TextButton));
    final color = button.style!.backgroundColor!.resolve({});

    expect(color, equals(Colors.grey));

    await tester.tap(find.byType(UINavButton));
    expect(pressed, isFalse);
  });
}
