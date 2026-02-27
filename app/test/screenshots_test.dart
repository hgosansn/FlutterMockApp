import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:flutter_mock_app/features/home/presentation/home_screen.dart';
import 'package:flutter_mock_app/features/profile/presentation/profile_screen.dart';
import 'package:flutter_mock_app/features/counter/presentation/counter_screen.dart';
import 'package:flutter_mock_app/features/home/providers/dashboard_provider.dart';
import 'package:flutter_mock_app/features/counter/providers/counter_provider.dart';
import 'package:flutter_mock_app/core/config/app_config.dart';

void main() {
  setUpAll(() {
    Animate.restartOnHotReload = true;
  });

  Widget wrapWithProviders(Widget child) {
    final dashboardProvider = DashboardProvider();
    // Pre-fill with mock data for stability
    dashboardProvider.userProfile = {
      'name': {'first': 'John', 'last': 'Doe'},
      'email': 'john.doe@example.com',
      'location': {'city': 'New York', 'country': 'USA'},
      'phone': '(555) 123-4567',
      'picture': {
        'large': 'https://randomuser.me/api/portraits/men/1.jpg',
        'thumbnail': 'https://randomuser.me/api/portraits/thumb/men/1.jpg',
      }
    };
    dashboardProvider.quote = {
      'content': 'Code is like humor. When you have to explain it, it’s bad.',
      'author': 'Cory House'
    };

    final counterProvider = CounterProvider();
    // Set a recognizable count
    for (int i = 0; i < 42; i++) counterProvider.increment();

    return MultiProvider(
      providers: [
        Provider<AppConfig>.value(value: AppConfig.dev()),
        ChangeNotifierProvider<DashboardProvider>.value(value: dashboardProvider),
        ChangeNotifierProvider<CounterProvider>.value(value: counterProvider),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 86, 192, 111)),
          useMaterial3: true,
          fontFamily: 'Roboto', // Use standard font
        ),
        home: child,
      ),
    );
  }

  Future<void> takeScreenshot(WidgetTester tester, Widget widget, String name) async {
    // Set typical mobile dimensions (iPhone 13-ish)
    tester.view.physicalSize = const Size(390 * 3, 844 * 3);
    tester.view.devicePixelRatio = 3.0;

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(wrapWithProviders(widget));
      // Allow animations and images to resolve
      await tester.pumpAndSettle();
      
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/$name.png'),
      );
    });
    
    // Reset view
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  }

  group('Screenshot Goldens', () {
    testWidgets('Home Screen', (tester) async {
      await takeScreenshot(tester, const HomeScreen(), 'home_screen');
    });

    testWidgets('Profile Screen', (tester) async {
      await takeScreenshot(tester, const ProfileScreen(), 'profile_screen');
    });

    testWidgets('Counter Screen', (tester) async {
      await takeScreenshot(tester, const CounterScreen(), 'counter_screen');
    });
  });
}
