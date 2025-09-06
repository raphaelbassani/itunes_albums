import 'package:flutter_test/flutter_test.dart';
import 'package:itunes_albums/core/enums/view_model_status.dart';

void main() {
  group('ViewModelStatus', () {
    test('isIdle should be true only for idle', () {
      expect(ViewModelStatus.idle.isIdle, true);
      expect(ViewModelStatus.loading.isIdle, false);
      expect(ViewModelStatus.success.isIdle, false);
      expect(ViewModelStatus.failure.isIdle, false);
    });

    test('isLoading should be true only for loading', () {
      expect(ViewModelStatus.idle.isLoading, false);
      expect(ViewModelStatus.loading.isLoading, true);
      expect(ViewModelStatus.success.isLoading, false);
      expect(ViewModelStatus.failure.isLoading, false);
    });

    test('isSuccess should be true only for success', () {
      expect(ViewModelStatus.idle.isSuccess, false);
      expect(ViewModelStatus.loading.isSuccess, false);
      expect(ViewModelStatus.success.isSuccess, true);
      expect(ViewModelStatus.failure.isSuccess, false);
    });

    test('isFailure should be true only for failure', () {
      expect(ViewModelStatus.idle.isFailure, false);
      expect(ViewModelStatus.loading.isFailure, false);
      expect(ViewModelStatus.success.isFailure, false);
      expect(ViewModelStatus.failure.isFailure, true);
    });
  });
}
