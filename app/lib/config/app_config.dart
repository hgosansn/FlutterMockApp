// Environment configuration layer.
//
// Usage:
//   flutter run --dart-define=APP_ENV=dev
//   flutter run --dart-define=APP_ENV=staging
//   flutter run --dart-define=APP_ENV=prod

enum AppEnvironment { dev, staging, prod }

class AppConfig {
  static const String _rawEnv =
      String.fromEnvironment('APP_ENV', defaultValue: 'dev');

  /// The resolved environment for this build.
  static final AppEnvironment environment = _parseEnv(_rawEnv);

  /// Human-readable environment label (shown in debug banners, logs, etc.)
  static String get label => environment.name;

  /// Whether this is a development build.
  static bool get isDev => environment == AppEnvironment.dev;

  /// Whether this is a production build.
  static bool get isProd => environment == AppEnvironment.prod;

  /// Firebase project IDs per environment.
  static String get firebaseProjectId {
    switch (environment) {
      case AppEnvironment.dev:
        return const String.fromEnvironment(
          'FIREBASE_PROJECT_DEV',
          defaultValue: 'fluttermockapp-dev',
        );
      case AppEnvironment.staging:
        return const String.fromEnvironment(
          'FIREBASE_PROJECT_STAGING',
          defaultValue: 'fluttermockapp-staging',
        );
      case AppEnvironment.prod:
        return const String.fromEnvironment(
          'FIREBASE_PROJECT_PROD',
          defaultValue: 'fluttermockapp-prod',
        );
    }
  }

  static AppEnvironment _parseEnv(String raw) {
    switch (raw.toLowerCase()) {
      case 'staging':
        return AppEnvironment.staging;
      case 'prod':
        return AppEnvironment.prod;
      default:
        return AppEnvironment.dev;
    }
  }
}
