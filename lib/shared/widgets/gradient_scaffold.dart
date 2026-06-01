import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

/// Wraps its [child] in the dark navy gradient in dark mode.
/// In light mode it is a transparent pass-through.
///
/// Usage: wrap the scrollable body content of a [PlatformScaffold], e.g.
/// ```dart
/// body: GradientScaffold(child: ListView(...))
/// ```
class GradientScaffold extends StatelessWidget {
  const GradientScaffold({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (!isDark) return child;

    return Container(
      decoration: const BoxDecoration(gradient: AppTheme.darkBgGradient),
      child: child,
    );
  }
}
