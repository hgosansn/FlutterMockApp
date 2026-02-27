import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GlassContainer extends StatelessWidget {
  const GlassContainer({
    super.key,
    required this.child,
    this.borderRadius = 24,
    this.blur = 10,
    this.opacity = 0.1,
    this.padding = const EdgeInsets.all(20),
    this.borderOpacity = 0.2,
    this.color,
  });

  final Widget child;
  final double borderRadius;
  final double blur;
  final double opacity;
  final EdgeInsetsGeometry padding;
  final double borderOpacity;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final themeColor = color ?? Theme.of(context).colorScheme.surface;
    
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: themeColor.withOpacity(opacity),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: themeColor.withOpacity(borderOpacity),
              width: 1.5,
            ),
          ),
          child: child,
        ),
      ),
    )
    .animate()
    .fadeIn(duration: 600.ms, curve: Curves.easeOut)
    .slideY(begin: 0.1, end: 0, duration: 600.ms, curve: Curves.easeOut);
  }
}
