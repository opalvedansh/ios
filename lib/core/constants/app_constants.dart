/// Application-wide constants
class AppConstants {
  // App Info
  static const String appName = 'ZepWash';
  static const String appTagline = 'Daily Car Wash Subscription';

  // Support
  static const String supportEmail = 'support@zepwash.com';
  static const String supportPhone = '+91 9876543210';

  // Onboarding
  static const int onboardingPages = 3;

  // OTP
  static const int otpLength = 6;
  static const Duration otpTimeout = Duration(seconds: 60);
  static const Duration otpResendDelay = Duration(seconds: 30);

  // Validation
  static const int phoneNumberLength = 10;
  static const int plateCodeLength = 6;
  static const int minNameLength = 3;

  // Razorpay — set via --dart-define at build time:
  //   flutter build appbundle --dart-define=RAZORPAY_KEY_ID=rzp_live_XXXXX
  // Falls back to test key for local dev only.
  static const String razorpayKeyId = String.fromEnvironment(
    'RAZORPAY_KEY_ID',
    defaultValue: 'rzp_test_SNZhMHcJpgRfOl',
  );

  // Firebase Collections (inherited from shared package)
  // Using Constants from zepwash_common

  // Image Upload
  static const int maxImageSizeMB = 5;
  static const List<String> allowedImageTypes = ['jpg', 'jpeg', 'png'];

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 50;

  // Cache
  static const Duration cacheExpiry = Duration(hours: 1);

  // URLs
  static const String privacyPolicyUrl = 'https://zepwash.com/privacy';
  static const String termsOfServiceUrl = 'https://zepwash.com/terms';
  static const String helpUrl = 'https://zepwash.com/help';
}
