import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_mock_app/app/app.dart';
import 'package:flutter_mock_app/core/config/app_config.dart';
import 'package:flutter_mock_app/features/counter/providers/counter_provider.dart';

void main() {
  group('App smoke tests', () {
    testWidgets('app renders without crashing (dev flavor)',
        (WidgetTester tester) async {
      await tester.pumpWidget(App(config: AppConfig.dev()));
      await tester.pumpAndSettle();
      expect(find.text('FlutterMockApp (dev)'), findsNothing);
      expect(find.text('Counter value'), findsOneWidget);
    });
  });

  group('CounterProvider unit tests', () {
    test('initial count is 0', () {
      final provider = CounterProvider();
      expect(provider.count, 0);
    });

    test('increment increases count by 1', () {
      final provider = CounterProvider();
      provider.increment();
      expect(provider.count, 1);
    });

    test('decrement decreases count by 1', () {
      final provider = CounterProvider();
      provider.increment();
      provider.decrement();
      expect(provider.count, 0);
    });

    test('decrement does not go below 0', () {
      final provider = CounterProvider();
      provider.decrement();
      expect(provider.count, 0);
    });

    test('reset sets count to 0', () {
      final provider = CounterProvider();
      provider.increment();
      provider.increment();
      provider.reset();
      expect(provider.count, 0);
    });
  });
}
