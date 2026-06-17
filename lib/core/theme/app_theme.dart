import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// App-wide theme configuration for both Material (Android) and Cupertino (iOS)
class AppTheme {
  // ── Light brand colors ────────────────────────────────────────────────────
  static const Color primary = Color(0xFF2563EB);
  static const Color secondary = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color success = Color(0xFF10B981);
  /// Neumorphic base — changed from #F9FAFB for proper shadow contrast
  static const Color background = Color(0xFFE8EDF2);
  static const Color surface = Colors.white;
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);

  // ── Dark theme colors ─────────────────────────────────────────────────────
  static const Color darkGradientStart = Color(0xFF0A0E1A);
  static const Color darkGradientEnd = Color(0xFF0D1635);
  static const Color darkSurface = Color(0xFF111827);
  static const Color darkSurfaceElevated = Color(0xFF1A2744);
  static const Color darkShadowDark = Color(0xFF070B14);
  static const Color darkShadowLight = Color(0xFF1E2D50);
  static const Color darkPrimary = Color(0xFF3B82F6);
  static const Color darkTextPrimary = Color(0xFFF9FAFB);
  static const Color darkTextSecondary = Color(0xFF9CA3AF);
  static const Color darkError = Color(0xFFF87171);
  static const Color darkSuccess = Color(0xFF34D399);
  static const Color darkWarning = Color(0xFFFBBF24);

  // ── Gradients ─────────────────────────────────────────────────────────────
  static const LinearGradient darkBgGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [darkGradientStart, darkGradientEnd],
  );

  // ── Material Themes ───────────────────────────────────────────────────────

  /// Material Theme (Android) — Light
  static ThemeData materialLight() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        brightness: Brightness.light,
        error: error,
      ),
      scaffoldBackgroundColor: background,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 1,
        backgroundColor: surface,
        foregroundColor: textPrimary,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.shade200),
        ),
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: error),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 8,
        backgroundColor: surface,
        selectedItemColor: primary,
        unselectedItemColor: textSecondary,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  /// Material Theme (Android) — Dark
  static ThemeData materialDark() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: darkPrimary,
        brightness: Brightness.dark,
        surface: darkSurface,
        error: darkError,
      ),
      scaffoldBackgroundColor: darkGradientStart,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 1,
        backgroundColor: darkSurface,
        foregroundColor: darkTextPrimary,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: darkSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: darkShadowLight.withValues(alpha: 0.4)),
        ),
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkSurfaceElevated,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: darkShadowLight.withValues(alpha: 0.4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: darkShadowLight.withValues(alpha: 0.4)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkPrimary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkError),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 8,
        backgroundColor: darkSurface,
        selectedItemColor: darkPrimary,
        unselectedItemColor: darkTextSecondary,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  // ── Cupertino Themes ──────────────────────────────────────────────────────

  /// Cupertino Theme (iOS) — Light
  static CupertinoThemeData cupertinoLight() {
    return const CupertinoThemeData(
      primaryColor: primary,
      brightness: Brightness.light,
      scaffoldBackgroundColor: CupertinoColors.systemGroupedBackground,
      barBackgroundColor: surface,
      textTheme: CupertinoTextThemeData(
        primaryColor: textPrimary,
      ),
    );
  }

  /// Cupertino Theme (iOS) — Dark
  static CupertinoThemeData cupertinoDark() {
    return const CupertinoThemeData(
      primaryColor: darkPrimary,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: CupertinoColors.systemGroupedBackground,
      barBackgroundColor: darkSurface,
      textTheme: CupertinoTextThemeData(
        primaryColor: darkTextPrimary,
      ),
    );
  }

  // ── Neumorphic Decorations ────────────────────────────────────────────────

  /// Neumorphic card BoxDecoration — picks light or dark shadow set
  static BoxDecoration neuCard(bool isDark, {double borderRadius = 16}) {
    return BoxDecoration(
      color: isDark ? darkSurface : background,
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: isDark
          ? [
              BoxShadow(
                color: darkShadowLight.withValues(alpha: 0.80),
                offset: const Offset(-5, -5),
                blurRadius: 10,
              ),
              BoxShadow(
                color: darkShadowDark.withValues(alpha: 0.90),
                offset: const Offset(5, 5),
                blurRadius: 10,
              ),
            ]
          : [
              BoxShadow(
                color: const Color(0xFFFFFFFF).withValues(alpha: 0.85),
                offset: const Offset(-6, -6),
                blurRadius: 12,
              ),
              BoxShadow(
                color: const Color(0xFFC8D0DA).withValues(alpha: 0.90),
                offset: const Offset(6, 6),
                blurRadius: 12,
              ),
            ],
    );
  }

  /// Glow decoration for active/primary elements
  static BoxDecoration glowDecoration(Color color, {bool isDark = false}) {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: isDark ? 0.45 : 0.40),
          offset: const Offset(0, 4),
          blurRadius: isDark ? 20 : 16,
          spreadRadius: isDark ? 3 : 2,
        ),
      ],
    );
  }

  // ── Context-aware text styles ─────────────────────────────────────────────
  // Use these instead of the bare const styles when the widget tree may be dark.

  static TextStyle resolvedHeading1(BuildContext context) => heading1.copyWith(
        color: Theme.of(context).brightness == Brightness.dark
            ? darkTextPrimary
            : textPrimary,
      );

  static TextStyle resolvedHeading2(BuildContext context) => heading2.copyWith(
        color: Theme.of(context).brightness == Brightness.dark
            ? darkTextPrimary
            : textPrimary,
      );

  static TextStyle resolvedHeading3(BuildContext context) => heading3.copyWith(
        color: Theme.of(context).brightness == Brightness.dark
            ? darkTextPrimary
            : textPrimary,
      );

  static TextStyle resolvedBodyLarge(BuildContext context) =>
      bodyLarge.copyWith(
        color: Theme.of(context).brightness == Brightness.dark
            ? darkTextPrimary
            : textPrimary,
      );

  static TextStyle resolvedBodyMedium(BuildContext context) =>
      bodyMedium.copyWith(
        color: Theme.of(context).brightness == Brightness.dark
            ? darkTextPrimary
            : textPrimary,
      );

  static TextStyle resolvedBodySmall(BuildContext context) =>
      bodySmall.copyWith(
        color: Theme.of(context).brightness == Brightness.dark
            ? darkTextSecondary
            : textSecondary,
      );

  static TextStyle resolvedCaption(BuildContext context) => caption.copyWith(
        color: Theme.of(context).brightness == Brightness.dark
            ? darkTextSecondary
            : textSecondary,
      );

  static Color resolvedTextSecondaryColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? darkTextSecondary
          : textSecondary;

  static Color resolvedPrimaryColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkPrimary : primary;

  // ── Const text styles (hardcode light colors — use resolved* in dark mode) ─

  static const TextStyle heading1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: textPrimary,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textPrimary,
  );

  static const TextStyle heading3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    color: textPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    color: textPrimary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    color: textSecondary,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    color: textSecondary,
  );
}
