import 'package:intl/intl.dart';

class Formatters {
  // Currency formatter (Indian Rupee)
  static String currency(num amount) {
    final formatter = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  // Phone number formatter
  static String phoneNumber(String phone) {
    // Format: +91 XXXXX XXXXX
    if (phone.startsWith('+91')) {
      final digits = phone.substring(3).replaceAll(RegExp(r'\D'), '');
      if (digits.length == 10) {
        return '+91 ${digits.substring(0, 5)} ${digits.substring(5)}';
      }
    }
    return phone;
  }

  // Date formatters
  static String date(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  static String dateTime(DateTime dateTime) {
    return DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
  }

  static String time(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }

  static String dateForFirestore(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  // Plate code formatter (always 6 characters, uppercase)
  static String plateCode(String code) {
    final cleaned = code.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');
    return cleaned.toUpperCase().padLeft(6, '0').substring(0, 6);
  }

  // Status badge text
  static String statusText(String status) {
    return status
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  // Relative time (e.g., "2 hours ago")
  static String relativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return date(dateTime);
    }
  }
}
