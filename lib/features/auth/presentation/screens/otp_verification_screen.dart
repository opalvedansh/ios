import 'dart:async';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/phone_auth_handler.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/platform_scaffold.dart';
import '../../../../shared/widgets/platform_button.dart';
import '../../../../shared/widgets/platform_alert.dart';

/// Strips the "Exception: " prefix that Dart adds to thrown exceptions,
/// so the user sees a clean message.
String _cleanError(Object e) {
  final raw = e.toString();
  if (raw.startsWith('Exception: ')) {
    return raw.substring('Exception: '.length);
  }
  return raw;
}

class OtpVerificationScreen extends ConsumerStatefulWidget {
  final String phoneNumber;
  final String reqId;

  const OtpVerificationScreen({
    super.key,
    required this.phoneNumber,
    required this.reqId,
  });

  @override
  ConsumerState<OtpVerificationScreen> createState() =>
      _OtpVerificationScreenState();
}

class _OtpVerificationScreenState
    extends ConsumerState<OtpVerificationScreen> {
  // 4-digit OTP to match MSG91 template configuration
  static const int _otpLength = 4;

  final List<TextEditingController> _otpControllers =
      List.generate(_otpLength, (_) => TextEditingController());
  final List<FocusNode> _focusNodes =
      List.generate(_otpLength, (_) => FocusNode());

  bool _isLoading = false;
  int _resendTimer = 30;
  Timer? _timer;
  late String _reqId;

  @override
  void initState() {
    super.initState();
    _reqId = widget.reqId;
    _startResendTimer();
  }

  @override
  void dispose() {
    for (final controller in _otpControllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  void _startResendTimer() {
    _timer?.cancel();
    setState(() => _resendTimer = 30);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendTimer > 0) {
        setState(() => _resendTimer--);
      } else {
        timer.cancel();
      }
    });
  }

  String _getOtpCode() => _otpControllers.map((c) => c.text).join();

  /// Clears all OTP input fields and focuses the first one.
  void _clearOtpFields() {
    for (final c in _otpControllers) {
      c.clear();
    }
    if (mounted) _focusNodes[0].requestFocus();
  }

  /// Distributes a pasted multi-digit string across the OTP fields.
  void _handlePaste(String value, int startIndex) {
    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) return;

    for (int i = 0; i < digits.length && (startIndex + i) < _otpLength; i++) {
      _otpControllers[startIndex + i].text = digits[i];
    }

    // Move focus to the next empty field or the last one
    final nextIndex = (startIndex + digits.length).clamp(0, _otpLength - 1);
    _focusNodes[nextIndex].requestFocus();

    // If all fields filled, attempt auto-submit
    if (_getOtpCode().length == _otpLength) {
      _verifyOTP();
    }
  }

  Future<void> _verifyOTP() async {
    // Guard against double submission
    if (_isLoading) return;

    final otp = _getOtpCode();
    if (otp.length != _otpLength) {
      showPlatformError(context, 'Please enter the complete $_otpLength-digit OTP');
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Step 1: Verify OTP with MSG91 → get JWT access token
      final accessToken = await PhoneAuthHandler.verifyOTP(_reqId, otp);

      // Step 2: Exchange JWT for Firebase custom token via Cloud Function
      final functions = FirebaseFunctions.instanceFor(region: 'asia-south1');
      final result = await functions
          .httpsCallable('verifyMsg91OTP')
          .call({'accessToken': accessToken});
      final customToken = result.data['customToken'] as String;

      // Step 3: Sign in to Firebase with the custom token
      await firebase_auth.FirebaseAuth.instance
          .signInWithCustomToken(customToken);

      if (!mounted) return;
      context.go('/home');
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      // Show clean error message (without "Exception: " prefix)
      showPlatformError(context, _cleanError(e));
      // Clear OTP fields so user can re-enter a correct OTP
      _clearOtpFields();
    }
  }

  Future<void> _resendOTP() async {
    try {
      final newReqId = await PhoneAuthHandler.retryOTP(_reqId);
      if (!mounted) return;
      setState(() => _reqId = newReqId);
      // Clear old OTP input so the user starts fresh
      _clearOtpFields();
      _startResendTimer();
      showPlatformSuccess(context, 'OTP sent successfully');
    } catch (e) {
      if (!mounted) return;
      showPlatformError(context, _cleanError(e));
    }
  }

  @override
  Widget build(BuildContext context) {
    // NOTE: PlatformScaffold already adds SafeArea on iOS (CupertinoPageScaffold).
    // We do NOT wrap body in another SafeArea to avoid double padding on iOS.
    return PlatformScaffold(
      title: 'Verify OTP',
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),

            const Icon(
              Icons.sms_outlined,
              size: 80,
              color: AppTheme.primary,
            ),
            const SizedBox(height: 32),

            Text(
              'Enter Verification Code',
              style: AppTheme.resolvedHeading2(context),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            Text(
              'We sent a $_otpLength-digit code to ${widget.phoneNumber}',
              style: AppTheme.resolvedBodyMedium(context).copyWith(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.darkTextSecondary
                    : AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:
                  List.generate(_otpLength, (index) => _buildOtpField(index)),
            ),
            const SizedBox(height: 24),

            PlatformButton(
              text: 'Verify',
              onPressed: _isLoading ? null : _verifyOTP,
              isLoading: _isLoading,
            ),
            const SizedBox(height: 16),

            Center(
              child: _resendTimer > 0
                  ? Text(
                      'Resend OTP in $_resendTimer seconds',
                      style: AppTheme.resolvedBodySmall(context),
                    )
                  : TextButton(
                      onPressed: _resendOTP,
                      child: const Text('Resend OTP'),
                    ),
            ),

            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpField(int index) {
    return SizedBox(
      width: 60,
      height: 72,
      child: TextField(
        controller: _otpControllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppTheme.primary, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (value) {
          // Handle paste — if somehow multiple chars land here, distribute them
          if (value.length > 1) {
            _handlePaste(value, index);
            return;
          }

          if (value.length == 1) {
            // Advance to next field
            if (index < _otpLength - 1) {
              _focusNodes[index + 1].requestFocus();
            } else {
              // Last field filled — attempt auto-submit
              _focusNodes[index].unfocus();
              _verifyOTP();
            }
          } else if (value.isEmpty && index > 0) {
            // Backspace — go to previous field
            _focusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }
}
