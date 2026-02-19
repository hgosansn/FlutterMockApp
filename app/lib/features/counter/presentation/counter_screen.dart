import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/counter_provider.dart';

/// Interactive counter screen — demonstrates state management with Provider.
class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  static const String routeName = 'counter';
  static const String routePath = '/counter';

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CounterProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: BackButton(onPressed: () => context.pop()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You have pressed the button',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '${provider.count} time${provider.count == 1 ? '' : 's'}',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton.filled(
                  tooltip: 'Decrement',
                  onPressed: provider.count > 0 ? provider.decrement : null,
                  icon: const Icon(Icons.remove),
                ),
                const SizedBox(width: 24),
                IconButton.filled(
                  tooltip: 'Increment',
                  onPressed: provider.increment,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: provider.reset,
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
