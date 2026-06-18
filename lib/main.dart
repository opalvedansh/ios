import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'core/theme/app_theme.dart';
import 'core/routes/app_router.dart';
import 'core/providers/auth_provider.dart';
import 'core/providers/location_provider.dart';
import 'core/providers/preferences_provider.dart';
import 'core/providers/theme_provider.dart';
import 'core/services/notification_service.dart';
import 'core/services/phone_auth_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await NotificationService.initialize();
  PhoneAuthHandler.initialize();

  // Initialize SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();

  // Lock orientation to portrait (mobile only)
  if (!kIsWeb) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const ZepWashApp(),
    ),
  );
}

/// Main app widget
class ZepWashApp extends ConsumerStatefulWidget {
  const ZepWashApp({super.key});

  @override
  ConsumerState<ZepWashApp> createState() => _ZepWashAppState();
}

class _ZepWashAppState extends ConsumerState<ZepWashApp> {
  @override
  void initState() {
    super.initState();
    // Set up tap-to-navigate handlers after the first frame so the router is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final router = ref.read(routerProvider);
      NotificationService.instance.setupHandlers((route) => router.go(route));
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider);
    final isDark = themeMode == ThemeMode.dark;

    // Register/refresh FCM token and invalidate location whenever the user's auth state changes
    ref.listen<String?>(currentUserIdProvider, (previous, userId) {
      if (userId != null) {
        NotificationService.instance.requestPermissionAndSaveToken(userId);
        // Ensure location is re-requested after login
        ref.invalidate(currentPositionProvider);
      }
    });

    // Update status bar icons to match the current theme
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            isDark ? Brightness.light : Brightness.dark,
      ),
    );

    // Platform-specific app widget
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {
      return CupertinoApp.router(
        title: 'ZepWash',
        theme: isDark ? AppTheme.cupertinoDark() : AppTheme.cupertinoLight(),
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          DefaultMaterialLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        // Override platformBrightness so CupertinoColors adaptive palette
        // resolves correctly based on our app-level theme toggle.
        builder: (ctx, child) => MediaQuery(
          data: MediaQuery.of(ctx).copyWith(
            platformBrightness: isDark ? Brightness.dark : Brightness.light,
          ),
          child: child!,
        ),
      );
    }

    return MaterialApp.router(
      title: 'ZepWash',
      theme: AppTheme.materialLight(),
      darkTheme: AppTheme.materialDark(),
      themeMode: themeMode,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
