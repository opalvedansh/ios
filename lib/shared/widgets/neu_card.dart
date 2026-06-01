import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

/// A neumorphic surface card.
///
/// Use only for surface-colored (background) cards — NOT for tinted/colored cards
/// (e.g. the billing card with primary-opacity background).
class NeuCard extends StatelessWidget {
  const NeuCard({
    super.key,
    required this.child,
    this.padding = 16,
    this.borderRadius = 16.0,
    this.isActive = false,
    this.onTap,
    this.color,
  });

  final Widget child;
  final double padding;
  final double borderRadius;

  /// When true, reverses the shadow direction (pressed/inset effect).
  final bool isActive;

  /// If provided, wraps the card in an [InkWell] with the given callback.
  final VoidCallback? onTap;

  /// Override the surface color (optional).
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    BoxDecoration decoration = AppTheme.neuCard(isDark, borderRadius: borderRadius);

    if (color != null) {
      decoration = decoration.copyWith(color: color);
    }

    if (isActive) {
      // Composite glow on top of the neumorphic shadows
      final glowShadow = AppTheme.glowDecoration(
        isDark ? AppTheme.darkPrimary : AppTheme.primary,
        isDark: isDark,
      ).boxShadow!;

      decoration = decoration.copyWith(
        boxShadow: [...(decoration.boxShadow ?? []), ...glowShadow],
      );
    }

    Widget content = Padding(
      padding: EdgeInsets.all(padding),
      child: child,
    );

    if (onTap != null) {
      content = Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: content,
        ),
      );
    }

    return Container(
      decoration: decoration,
      child: content,
    );
  }
}
