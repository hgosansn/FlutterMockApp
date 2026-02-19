import 'package:flutter/material.dart';

import 'app/app.dart';
import 'core/config/app_config.dart';

/// Staging flavor entry point.
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App(config: AppConfig.staging()));
}
