import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/config/app_config.dart';
import '../core/router/app_router.dart';
import '../features/counter/providers/counter_provider.dart';

/// Root application widget.
///
/// Receives an [AppConfig] at construction time so each flavor entry-point can
/// inject its own configuration without changing any business logic.
class App extends StatelessWidget {
  const App({super.key, required this.config});

  final AppConfig config;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Expose the per-flavor configuration everywhere in the widget tree.
        Provider<AppConfig>.value(value: config),

        // Feature providers
        ChangeNotifierProvider(create: (_) => CounterProvider()),
      ],
      child: MaterialApp.router(
        title: config.appName,
        debugShowCheckedModeBanner: config.isDev,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
