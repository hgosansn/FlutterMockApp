import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/widgets/glass_container.dart';
import '../providers/counter_provider.dart';

/// Redesigned Counter screen with modern glassmorphism and animations.
class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  static const String routeName = 'counter';
  static const String routePath = '/counter';

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CounterProvider>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        title: const Text('Statistics'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.go('/'),
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

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const Spacer(),
                  
                  // Main Counter Display
                  GlassContainer(
                    blur: 20,
                    opacity: 0.1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'TOTAL INTERACTIONS',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                letterSpacing: 2,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary,
                              ),
                        ),
                        const SizedBox(height: 16),
                        // Animated Switcher for the number change
                        AnimatedSwitcher(
                          duration: 400.ms,
                          transitionBuilder: (child, animation) {
                            return FadeTransition(
                              opacity: animation,
                              child: ScaleTransition(
                                scale: animation.drive(Tween(begin: 0.8, end: 1.0)),
                                child: child,
                              ),
                            );
                          },
                          child: Text(
                            '${provider.count}',
                            key: ValueKey<int>(provider.count),
                            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 80,
                                  color: colorScheme.onSurface,
                                ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Last updated: Just now',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurface.withOpacity(0.5),
                              ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 800.ms).scale(begin: const Offset(0.9, 0.9)),

                  const SizedBox(height: 48),

                  // Interaction Controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _ActionButton(
                        icon: Icons.remove_rounded,
                        onPressed: provider.count > 0 ? provider.decrement : null,
                        color: colorScheme.secondary,
                      ),
                      const SizedBox(width: 32),
                      _ActionButton(
                        icon: Icons.add_rounded,
                        onPressed: provider.increment,
                        color: colorScheme.primary,
                        isLarge: true,
                      ),
                      const SizedBox(width: 32),
                      _ActionButton(
                        icon: Icons.refresh_rounded,
                        onPressed: provider.reset,
                        color: colorScheme.error,
                      ),
                    ],
                  ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),

                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    this.onPressed,
    required this.color,
    this.isLarge = false,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final Color color;
  final bool isLarge;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IconButton.filled(
        onPressed: onPressed,
        iconSize: isLarge ? 32 : 24,
        padding: EdgeInsets.all(isLarge ? 20 : 16),
        style: IconButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          disabledBackgroundColor: color.withOpacity(0.2),
        ),
        icon: Icon(icon),
      ),
    );
  }
}
