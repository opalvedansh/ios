import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/providers/preferences_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/platform_button.dart';

/// Onboarding screen with feature introduction
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      imagePath: 'assets/images/logo_name.png',
      title: 'Daily Car Wash',
      description:
          'Subscribe to daily car wash service and keep your vehicle spotless every day',
    ),
    OnboardingPage(
      icon: Icons.calendar_today,
      title: 'Track Attendance',
      description:
          'View daily cleaning records with photo proof and track your subscription',
    ),
    OnboardingPage(
      icon: Icons.support_agent,
      title: '24/7 Support',
      description:
          'Raise complaints, track resolution, and get help whenever you need',
    ),
  ];

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  Future<void> _onGetStarted() async {
    await ref.read(sharedPreferencesProvider).setBool('has_seen_onboarding', true);
    // Invalidate so hasSeenOnboardingProvider re-reads the updated value.
    // Without this the router caches false and redirects back to onboarding.
    ref.invalidate(hasSeenOnboardingProvider);

    if (mounted) {
      context.go('/auth/phone');
    }
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _onGetStarted();
    }
  }

  void _skipOnboarding() {
    _onGetStarted();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: _skipOnboarding,
                child: const Text('Skip'),
              ),
            ),

            // Page view
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _buildPage(_pages[index]);
                },
              ),
            ),

            // Page indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => _buildPageIndicator(index == _currentPage),
              ),
            ),
            const SizedBox(height: 32),

            // Next/Get Started button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                child: PlatformButton(
                  text: _currentPage == _pages.length - 1
                      ? 'Get Started'
                      : 'Next',
                  onPressed: _nextPage,
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingPage page) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon or image
          if (page.imagePath != null)
            Image.asset(
              page.imagePath!,
              height: 80,
              fit: BoxFit.contain,
            )
          else
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppTheme.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                page.icon!,
                size: 60,
                color: AppTheme.primary,
              ),
            ),
          const SizedBox(height: 48),

          // Title
          Text(
            page.title,
            style: AppTheme.resolvedHeading2(context),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // Description
          Text(
            page.description,
            style: AppTheme.resolvedBodyLarge(context).copyWith(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppTheme.darkTextSecondary
                  : AppTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(bool isActive) {
    return Builder(
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: isActive ? 24 : 8,
          decoration: BoxDecoration(
            color: isActive
                ? AppTheme.primary
                : isDark
                    ? Colors.grey.shade700
                    : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      },
    );
  }
}

/// Onboarding page data model
class OnboardingPage {
  final IconData? icon;
  final String? imagePath;
  final String title;
  final String description;

  OnboardingPage({
    this.icon,
    this.imagePath,
    required this.title,
    required this.description,
  }) : assert(icon != null || imagePath != null, 'Either icon or imagePath must be provided');
}
