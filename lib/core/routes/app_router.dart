import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';
import '../providers/preferences_provider.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/auth/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/phone_input_screen.dart';
import '../../features/auth/presentation/screens/otp_verification_screen.dart';
import '../../features/auth/presentation/screens/web_landing_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/subscription/presentation/screens/add_vehicle_screen.dart';
import '../../features/subscription/presentation/screens/vehicle_details_screen.dart';
import '../../features/subscription/presentation/screens/subscription_details_screen.dart';
import '../../features/attendance/presentation/screens/attendance_screen.dart';
import '../../features/complaints/presentation/screens/complaints_screen.dart';
import '../../features/complaints/presentation/screens/create_complaint_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';

/// Listens to auth state changes and notifies GoRouter to re-run its redirect.
/// Using a ChangeNotifier + refreshListenable keeps the GoRouter instance
/// stable — it is never recreated on auth changes, so the current route is
/// preserved and the redirect fires correctly after OTP verification.
class _RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  _RouterNotifier(this._ref) {
    _ref.listen<AsyncValue<firebase_auth.User?>>(
      authStateProvider,
      (_, __) => notifyListeners(),
    );
  }

  String? redirect(BuildContext context, GoRouterState state) {
    final authState = _ref.read(authStateProvider);
    final firebaseAuth = _ref.read(firebaseAuthProvider);
    final hasSeenOnboarding = _ref.read(hasSeenOnboardingProvider);

    final isOnSplash = state.matchedLocation == '/splash';
    final isOnAuth = state.matchedLocation.startsWith('/auth');
    final isOnOnboarding = state.matchedLocation == '/onboarding';
    final isOnWebLanding = state.matchedLocation == '/web';

    // Auth stream hasn't emitted yet — hold at splash until we know the state.
    if (authState.isLoading) {
      return isOnSplash ? null : '/splash';
    }

    // On Flutter web there can be a short delay between a successful phone
    // auth confirmation and the provider stream catching up. Prefer the stream,
    // but fall back to currentUser once the auth state has settled.
    final isLoggedIn = authState.value != null || firebaseAuth.currentUser != null;

    // Logged in → leave auth/landing screens immediately.
    if (isLoggedIn && (isOnAuth || isOnOnboarding || isOnWebLanding)) {
      return '/home';
    }

    // Web: logged-out users on a non-auth route → marketing landing.
    // Auth routes (/auth/phone, /auth/otp) and /web itself are allowed.
    if (kIsWeb && !isLoggedIn && !isOnAuth && !isOnWebLanding && !isOnSplash) {
      if (kDebugMode) {
        debugPrint('[Router] web unauthenticated at ${state.matchedLocation} → /web');
      }
      return '/web';
    }

    // Mobile: not logged in → onboarding (first visit) or phone input.
    if (!kIsWeb && !isLoggedIn && !isOnAuth && !isOnOnboarding && !isOnSplash) {
      if (kDebugMode) {
        debugPrint('[Router] unauthenticated at ${state.matchedLocation} '
            '→ ${hasSeenOnboarding ? '/auth/phone' : '/onboarding'}');
      }
      return hasSeenOnboarding ? '/auth/phone' : '/onboarding';
    }

    return null;
  }
}

final _routerNotifierProvider = Provider<_RouterNotifier>((ref) {
  return _RouterNotifier(ref);
});

/// App router provider — GoRouter is created once and never recreated.
/// Auth-driven redirects are triggered via refreshListenable.
final routerProvider = Provider<GoRouter>((ref) {
  final notifier = ref.watch(_routerNotifierProvider);

  return GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    refreshListenable: notifier,
    redirect: notifier.redirect,
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/web',
        name: 'web-landing',
        builder: (context, state) => const WebLandingScreen(),
      ),
      GoRoute(
        path: '/auth/phone',
        name: 'phone-input',
        builder: (context, state) => const PhoneInputScreen(),
      ),
      GoRoute(
        path: '/auth/otp',
        name: 'otp-verification',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return OtpVerificationScreen(
            phoneNumber: extra?['phone'] as String? ?? '',
            reqId: extra?['reqId'] as String? ?? '',
          );
        },
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      // Add a new vehicle to an existing account — reuses same VehicleDetailsScreen
      GoRoute(
        path: '/home/add-vehicle',
        name: 'add-vehicle',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          if (extra != null) {
            return VehicleDetailsScreen(
              areaId: extra['areaId'] as String,
              vehicleType: extra['vehicleType'] as String,
              planId: extra['planId'] as String,
              monthlyPrice: extra['monthlyPrice'] as int,
            );
          }
          // No plan pre-selected — show plan picker for new vehicle
          return const AddVehicleScreen();
        },
      ),
      GoRoute(
        path: '/vehicle-details',
        name: 'vehicle-details',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return VehicleDetailsScreen(
            areaId: extra['areaId'] as String,
            vehicleType: extra['vehicleType'] as String,
            planId: extra['planId'] as String,
            monthlyPrice: extra['monthlyPrice'] as int,
          );
        },
      ),
      GoRoute(
        path: '/subscription',
        name: 'subscription-details',
        builder: (context, state) => const SubscriptionDetailsScreen(),
      ),
      GoRoute(
        path: '/attendance',
        name: 'attendance',
        builder: (context, state) => const AttendanceScreen(),
      ),
      GoRoute(
        path: '/complaints',
        name: 'complaints',
        builder: (context, state) => const ComplaintsScreen(),
      ),
      GoRoute(
        path: '/complaints/create',
        name: 'create-complaint',
        builder: (context, state) => const CreateComplaintScreen(),
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Page not found: ${state.matchedLocation}'),
          ],
        ),
      ),
    ),
  );
});
