import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:itunes_albums/core/ui/ui_app_bar.dart';
import 'package:itunes_albums/core/ui/ui_app_bar_title.dart';

void main() {
  testWidgets('UIAppBar displays the title', (tester) async {
    const testTitle = 'My AppBar';

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(appBar: UIAppBar(title: testTitle)),
      ),
    );

    expect(find.text(testTitle), findsOneWidget);
    expect(find.byType(UIAppBarTitle), findsOneWidget);
  });

  testWidgets('UIAppBar shows leading icon when hasLeading is true', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(appBar: UIAppBar(title: 'Test', hasLeading: true)),
      ),
    );

    expect(find.byType(IconButton), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
  });

  testWidgets('UIAppBar does not show leading icon when hasLeading is false', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(appBar: UIAppBar(title: 'Test', hasLeading: false)),
      ),
    );

    expect(find.byType(IconButton), findsNothing);
  });

  testWidgets('Clicking leading icon calls Navigator.pop', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const Scaffold(
                    appBar: UIAppBar(title: 'Test', hasLeading: true),
                  ),
                ),
              );
            },
            child: const Text('Next'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.arrow_back), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.text('Next'), findsOneWidget);
  });
}
