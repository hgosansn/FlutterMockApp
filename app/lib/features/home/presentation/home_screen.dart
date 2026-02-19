import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../counter/presentation/counter_screen.dart';
import '../../counter/providers/counter_provider.dart';

/// Main home screen — entry point after launch.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = 'home';
  static const String routePath = '/';

  @override
  Widget build(BuildContext context) {
    final count = context.watch<CounterProvider>().count;

    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterMockApp'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Counter value',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              '$count',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: () => context.goNamed(CounterScreen.routeName),
              icon: const Icon(Icons.add_circle_outline),
              label: const Text('Open counter'),
            ),
          ],
        ),
      ),
    );
  }
}
