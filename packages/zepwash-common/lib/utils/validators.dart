class Validators {
  // Phone number validation (Indian format)
  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    // Remove all non-digit characters
    final digits = value.replaceAll(RegExp(r'\D'), '');

    // Check for valid Indian phone number (10 digits)
    if (digits.length == 10) {
      return null;
    }

    // Check for valid international format (+91 followed by 10 digits)
    if (digits.length == 12 && digits.startsWith('91')) {
      return null;
    }

    return 'Please enter a valid 10-digit phone number';
  }

  // Email validation
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  // Required field validation
  static String? required(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    return null;
  }

  // Minimum length validation
  static String? minLength(String? value, int minLength, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }

    if (value.length < minLength) {
      return '${fieldName ?? 'This field'} must be at least $minLength characters';
    }

    return null;
  }

  // Maximum length validation
  static String? maxLength(String? value, int maxLength, [String? fieldName]) {
    if (value != null && value.length > maxLength) {
      return '${fieldName ?? 'This field'} must be at most $maxLength characters';
    }

    return null;
  }

  // Plate code validation (6 characters, alphanumeric)
  static String? plateCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vehicle plate code is required';
    }

    final cleaned = value.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');

    if (cleaned.length != 6) {
      return 'Plate code must be exactly 6 characters';
    }

    return null;
  }

  // OTP validation (6 digits)
  static String? otp(String? value) {
    if (value == null || value.isEmpty) {
      return 'OTP is required';
    }

    if (value.length != 6) {
      return 'OTP must be 6 digits';
    }

    if (!RegExp(r'^\d{6}$').hasMatch(value)) {
      return 'OTP must contain only numbers';
    }

    return null;
  }

  // Amount validation (positive number)
  static String? amount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Amount is required';
    }

    final amount = num.tryParse(value);
    if (amount == null || amount <= 0) {
      return 'Please enter a valid amount';
    }

    return null;
  }
}
