import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:itunes_albums/core/ui/ui_dimens.dart';

void main() {
  group('UIPadding', () {
    test('df padding should be EdgeInsets.all(16)', () {
      expect(UIPadding.df, const EdgeInsets.all(16));
    });
  });

  group('UIPaddingHorizontal', () {
    test('df padding should be horizontal 16', () {
      expect(
        UIPaddingHorizontal.df,
        const EdgeInsets.symmetric(horizontal: 16),
      );
    });

    test('lg padding should be horizontal 24', () {
      expect(
        UIPaddingHorizontal.lg,
        const EdgeInsets.symmetric(horizontal: 24),
      );
    });
  });

  group('UIPaddingVertical', () {
    test('xs padding should be vertical 4', () {
      expect(UIPaddingVertical.xs, const EdgeInsets.symmetric(vertical: 4));
    });

    test('sm padding should be vertical 8', () {
      expect(UIPaddingVertical.sm, const EdgeInsets.symmetric(vertical: 8));
    });

    test('df padding should be vertical 16', () {
      expect(UIPaddingVertical.df, const EdgeInsets.symmetric(vertical: 16));
    });

    test('lg padding should be vertical 24', () {
      expect(UIPaddingVertical.lg, const EdgeInsets.symmetric(vertical: 24));
    });
  });

  group('UIPaddingBottom', () {
    test('xs padding should be bottom 4', () {
      expect(UIPaddingBottom.xs, const EdgeInsets.only(bottom: 4));
    });

    test('sm padding should be bottom 8', () {
      expect(UIPaddingBottom.sm, const EdgeInsets.only(bottom: 8));
    });

    test('df padding should be bottom 16', () {
      expect(UIPaddingBottom.df, const EdgeInsets.only(bottom: 16));
    });

    test('lg padding should be bottom 24', () {
      expect(UIPaddingBottom.lg, const EdgeInsets.only(bottom: 24));
    });
  });

  group('UISpacingStack', () {
    testWidgets('xxs SizedBox height is 2', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: UISpacingStack.xxs)),
      );

      final box = tester.widget<SizedBox>(find.byType(SizedBox));
      expect(box.height, 2);
    });

    testWidgets('df SizedBox height is 16', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: UISpacingStack.df)),
      );

      final box = tester.widget<SizedBox>(find.byType(SizedBox));
      expect(box.height, 16);
    });
  });

  group('UISpacingInLine', () {
    testWidgets('xs SizedBox width is 4', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: UISpacingInLine.xs)),
      );

      final box = tester.widget<SizedBox>(find.byType(SizedBox));
      expect(box.width, 4);
    });

    testWidgets('df SizedBox width is 16', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: UISpacingInLine.df)),
      );

      final box = tester.widget<SizedBox>(find.byType(SizedBox));
      expect(box.width, 16);
    });
  });
}
