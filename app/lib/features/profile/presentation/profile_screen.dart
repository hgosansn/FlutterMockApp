import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/widgets/glass_container.dart';
import '../../home/providers/dashboard_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const String routeName = 'profile';
  static const String routePath = '/profile';

  @override
  Widget build(BuildContext context) {
    final user = context.watch<DashboardProvider>().userProfile;
    final colorScheme = Theme.of(context).colorScheme;

    if (user == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final name = user['name'];
    final location = user['location'];
    final email = user['email'];
    final picture = user['picture']['large'];

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        title: const Text('Member Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?q=80&w=2560&auto=format&fit=crop',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: colorScheme.surface.withOpacity(0.2),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  
                  // Profile Avatar with Hero-like animation (manual for now)
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: colorScheme.primary, width: 2),
                      ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(picture),
                      ),
                    ).animate().scale(duration: 600.ms, curve: Curves.easeOutBack).fadeIn(),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  Text(
                    '${name['first']} ${name['last']}',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2),
                  
                  Text(
                    email,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.6),
                        ),
                  ).animate().fadeIn(delay: 300.ms),

                  const SizedBox(height: 40),

                  // Detail Cards
                  _ProfileDetailCard(
                    icon: Icons.location_on_rounded,
                    title: 'Location',
                    subtitle: '${location['city']}, ${location['country']}',
                    delay: 400.ms,
                  ),
                  
                  _ProfileDetailCard(
                    icon: Icons.phone_android_rounded,
                    title: 'Phone',
                    subtitle: user['phone'],
                    delay: 500.ms,
                  ),
                  
                  _ProfileDetailCard(
                    icon: Icons.calendar_today_rounded,
                    title: 'Member Since',
                    subtitle: 'October 2023', // Static mock for now
                    delay: 600.ms,
                  ),

                  const SizedBox(height: 40),

                  FilledButton.icon(
                    onPressed: () => context.read<DashboardProvider>().fetchRandomUser(),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('Fetch New Profile'),
                  ).animate().fadeIn(delay: 700.ms),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileDetailCard extends StatelessWidget {
  const _ProfileDetailCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.delay = Duration.zero,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                      ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ],
        ),
      ).animate(delay: delay).fadeIn().slideX(begin: 0.1),
    );
  }
}
