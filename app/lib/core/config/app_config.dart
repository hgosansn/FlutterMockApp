import 'environment.dart';

/// Holds environment-specific configuration values.
///
/// Instantiate once per flavor entry-point and expose via [Provider].
class AppConfig {
  const AppConfig({
    required this.environment,
    required this.appName,
    this.enableMockData = true,
  });

  final Environment environment;
  final String appName;
  final bool enableMockData;

  // ---------------------------------------------------------------------------
  // Convenience factories per flavor
  // ---------------------------------------------------------------------------

  factory AppConfig.dev() => const AppConfig(
        environment: Environment.dev,
        appName: 'FlutterMockApp (dev)',
        enableMockData: true,
      );

  factory AppConfig.staging() => const AppConfig(
        environment: Environment.staging,
        appName: 'FlutterMockApp (staging)',
        enableMockData: true,
      );

  factory AppConfig.prod() => const AppConfig(
        environment: Environment.prod,
        appName: 'FlutterMockApp',
        enableMockData: false,
      );

  bool get isDev => environment == Environment.dev;
  bool get isStaging => environment == Environment.staging;
  bool get isProd => environment == Environment.prod;
}
