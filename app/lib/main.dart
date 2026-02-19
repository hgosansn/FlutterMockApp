import 'package:flutter/material.dart';

import 'app/app.dart';
import 'core/config/app_config.dart';

/// Development flavor entry point.
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App(config: AppConfig.dev()));
}
