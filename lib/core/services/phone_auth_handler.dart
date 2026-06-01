import 'package:flutter/foundation.dart';
import 'package:sendotp_flutter_sdk/sendotp_flutter_sdk.dart';

const _widgetId = '3664426b7734333031373831';
const _authToken = '512438TewieMkc69f0ad08P1';

class PhoneAuthHandler {
  static bool _initialized = false;

  static void initialize() {
    if (_initialized) return;
    OTPWidget.initializeWidget(_widgetId, _authToken);
    _initialized = true;
  }

  /// Sends OTP via MSG91 SMS. Returns [reqId] on success, throws on error.
  /// [phoneNumber] must include country code without +, e.g. "917XXXXXXXXXX".
  static Future<String> sendOTP(String phoneNumber) async {
    final identifier = phoneNumber.startsWith('+')
        ? phoneNumber.substring(1)
        : phoneNumber;
    final response = await OTPWidget.sendOTP({'identifier': identifier});
    debugPrint('[MSG91] sendOTP response: $response');
    if (response != null && response['type'] == 'success') {
      return response['message'].toString();
    }
    throw Exception(
        response?['message'] as String? ?? 'Failed to send OTP');
  }

  /// Retries OTP delivery via SMS (channel 11). Returns new [reqId].
  static Future<String> retryOTP(String reqId) async {
    final response = await OTPWidget.retryOTP({'reqId': reqId});
    debugPrint('[MSG91] retryOTP response: $response');
    if (response != null && response['type'] == 'success') {
      return response['message'].toString();
    }
    throw Exception(
        response?['message'] as String? ?? 'Failed to resend OTP');
  }

  /// Verifies OTP entered by user. Returns JWT access token on success, throws on error.
  static Future<String> verifyOTP(String reqId, String otp) async {
    final response = await OTPWidget.verifyOTP({'reqId': reqId, 'otp': otp});
    debugPrint('[MSG91] verifyOTP response: $response');
    if (response != null && response['type'] == 'success') {
      return response['message'].toString();
    }
    throw Exception(
        response?['message'] as String? ?? 'Invalid OTP. Please try again.');
  }
}
