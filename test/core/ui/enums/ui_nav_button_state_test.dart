import 'package:flutter_test/flutter_test.dart';
import 'package:itunes_albums/core/ui/enums/ui_nav_button_state.dart';

void main() {
  group('UINavButtonState', () {
    test('enabled returns true for isEnabled', () {
      final state = UINavButtonState.enabled;
      expect(state.isEnabled, isTrue);
    });

    test('disabled returns false for isEnabled', () {
      final state = UINavButtonState.disabled;
      expect(state.isEnabled, isFalse);
    });
  });
}
