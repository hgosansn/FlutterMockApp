import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_mock_app/config/app_config.dart';

void main() {
  group('AppConfig', () {
    test('defaults to dev environment', () {
      // APP_ENV is not set during tests — defaults to "dev".
      expect(AppConfig.environment, AppEnvironment.dev);
      expect(AppConfig.isDev, isTrue);
      expect(AppConfig.isProd, isFalse);
      expect(AppConfig.label, 'dev');
    });

    test('returns dev firebase project id by default', () {
      expect(AppConfig.firebaseProjectId, 'fluttermockapp-dev');
    });
  });
}
