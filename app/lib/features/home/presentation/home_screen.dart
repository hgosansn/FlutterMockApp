import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/widgets/glass_container.dart';
import '../../counter/presentation/counter_screen.dart';
import '../../counter/providers/counter_provider.dart';
import '../../profile/presentation/profile_screen.dart';
import '../providers/dashboard_provider.dart';

/// Main home screen — redesigned with a modern Bento-grid aesthetic and dynamic API data.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = 'home';
  static const String routePath = '/';

  @override
  Widget build(BuildContext context) {
    final count = context.watch<CounterProvider>().count;
    final dashboard = context.watch<DashboardProvider>();
    final colorScheme = Theme.of(context).colorScheme;

    final user = dashboard.userProfile;
    final quote = dashboard.quote;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: Stack(
        children: [
          // Background Image with subtle overlay
          Positioned.fill(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
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
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome Back,',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.7),
                        ),
                  ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1),
                  Text(
                    'Explorer 👋',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                  ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.1),
                  const SizedBox(height: 32),
                  
                  // Bento Grid
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // Featured Quote Card
                      _QuoteCard(
                        quote: quote,
                        delay: 300.ms,
                        isLoading: dashboard.isLoadingQuote,
                      ),
                      const SizedBox(height: 16),
                      
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.9,
                        children: [
                          // User Profile Card
                          _UserProfileCard(
                            user: user,
                            onTap: () => context.pushNamed(ProfileScreen.routeName),
                            delay: 400.ms,
                            isLoading: dashboard.isLoadingUser,
                          ),

                          _BentoCard(
                            title: 'Counter',
                            subtitle: '$count',
                            icon: Icons.analytics_rounded,
                            color: colorScheme.primary,
                            onTap: () => context.pushNamed(CounterScreen.routeName),
                            delay: 500.ms,
                          ),

                          _BentoCard(
                            title: 'Performance',
                            subtitle: 'Optimal',
                            icon: Icons.speed_rounded,
                            color: Colors.orange,
                            delay: 600.ms,
                          ),
                          
                          _BentoCard(
                            title: 'Security',
                            subtitle: 'Safe',
                            icon: Icons.shield_moon_rounded,
                            color: Colors.blue,
                            delay: 700.ms,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuoteCard extends StatelessWidget {
  const _QuoteCard({this.quote, required this.delay, required this.isLoading});
  final Map<String, dynamic>? quote;
  final Duration delay;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.format_quote_rounded, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 12),
          if (isLoading)
            const LinearProgressIndicator()
          else if (quote != null) ...[
            Text(
              quote?['content'] ?? '',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              '- ${quote?['author'] ?? 'Unknown'}',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  ),
            ),
          ],
        ],
      ),
    ).animate(delay: delay).fadeIn().slideY(begin: 0.1);
  }
}

class _UserProfileCard extends StatelessWidget {
  const _UserProfileCard({this.user, this.onTap, required this.delay, required this.isLoading});
  final Map<String, dynamic>? user;
  final VoidCallback? onTap;
  final Duration delay;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return GlassContainer(
      padding: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isLoading)
                const Expanded(child: Center(child: CircularProgressIndicator(strokeWidth: 2)))
              else if (user != null) ...[
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: colorScheme.primary, width: 1.5),
                  ),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(user!['picture']['thumbnail']),
                  ),
                ),
                const Spacer(),
                Text(
                  'Member Profile',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface.withOpacity(0.5),
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  user!['name']['first'],
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ],
          ),
        ),
      ),
    ).animate(delay: delay).fadeIn().scale(begin: const Offset(0.9, 0.9));
  }
}

class _BentoCard extends StatelessWidget {
  const _BentoCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.onTap,
    this.isLarge = false,
    this.delay = Duration.zero,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
  final bool isLarge;
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ).animate(delay: delay).fadeIn().scale(begin: const Offset(0.9, 0.9));
  }
}

class _CircleBlur extends StatelessWidget {
  const _CircleBlur({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
