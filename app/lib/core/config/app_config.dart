import 'environment.dart';

/// Holds environment-specific configuration values.
///
/// Instantiate once per flavor entry-point and expose via [Provider].
class AppConfig {
  const AppConfig({
    required this.environment,
    required this.appName,
    required this.apiBaseUrl,
    required this.firebaseProjectId,
    this.enableAnalytics = false,
  });

  final Environment environment;
  final String appName;
  final String apiBaseUrl;
  final String firebaseProjectId;
  final bool enableAnalytics;

  // ---------------------------------------------------------------------------
  // Convenience factories per flavor
  // ---------------------------------------------------------------------------

  factory AppConfig.dev() => const AppConfig(
        environment: Environment.dev,
        appName: 'FlutterMockApp (dev)',
        apiBaseUrl: 'https://dev-api.fluttermockapp.example.com',
        firebaseProjectId: 'flutter-mock-app-dev',
        enableAnalytics: false,
      );

  factory AppConfig.staging() => const AppConfig(
        environment: Environment.staging,
        appName: 'FlutterMockApp (staging)',
        apiBaseUrl: 'https://staging-api.fluttermockapp.example.com',
        firebaseProjectId: 'flutter-mock-app-staging',
        enableAnalytics: false,
      );

  factory AppConfig.prod() => const AppConfig(
        environment: Environment.prod,
        appName: 'FlutterMockApp',
        apiBaseUrl: 'https://api.fluttermockapp.example.com',
        firebaseProjectId: 'flutter-mock-app-prod',
        enableAnalytics: true,
      );

  bool get isDev => environment == Environment.dev;
  bool get isStaging => environment == Environment.staging;
  bool get isProd => environment == Environment.prod;
}
