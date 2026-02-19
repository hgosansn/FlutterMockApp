import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/provider/auth_provider.dart';
import 'provider/home_provider.dart';

/// Home screen — shown after a successful sign-in.
///
/// Fetches and displays a personalised welcome message from Firestore.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final authProvider = context.read<AuthProvider>();
        final homeProvider = HomeProvider();
        if (authProvider.user != null) {
          homeProvider.fetchWelcomeMessage(authProvider.user!.uid);
        }
        return homeProvider;
      },
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final homeProvider = context.watch<HomeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sign out',
            onPressed: authProvider.signOut,
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (authProvider.user?.photoURL != null)
                  CircleAvatar(
                    radius: 40,
                    backgroundImage:
                        NetworkImage(authProvider.user!.photoURL!),
                  )
                else
                  const CircleAvatar(
                    radius: 40,
                    child: Icon(Icons.person, size: 40),
                  ),
                const SizedBox(height: 16),
                Text(
                  authProvider.user?.displayName ?? 'User',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),
                if (homeProvider.isLoading)
                  const CircularProgressIndicator()
                else if (homeProvider.errorMessage != null)
                  Text(
                    homeProvider.errorMessage!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                    textAlign: TextAlign.center,
                  )
                else
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        homeProvider.message ?? '',
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                const SizedBox(height: 32),
                OutlinedButton.icon(
                  onPressed: () {
                    if (authProvider.user != null) {
                      homeProvider.fetchWelcomeMessage(authProvider.user!.uid);
                    }
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Refresh'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
