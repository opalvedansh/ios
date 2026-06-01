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
  final List<TextEditingController> _otpControllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

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

  Future<void> _verifyOTP() async {
    final otp = _getOtpCode();
    if (otp.length != 4) {
      showPlatformError(context, 'Please enter complete OTP');
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
      showPlatformError(context, e.toString());
    }
  }

  Future<void> _resendOTP() async {
    try {
      final newReqId = await PhoneAuthHandler.retryOTP(_reqId);
      if (!mounted) return;
      setState(() => _reqId = newReqId);
      _startResendTimer();
      showPlatformSuccess(context, 'OTP sent successfully');
    } catch (e) {
      if (!mounted) return;
      showPlatformError(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      title: 'Verify OTP',
      body: SafeArea(
        child: Padding(
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
                'We sent a code to ${widget.phoneNumber}',
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
                children: List.generate(4, (index) => _buildOtpField(index)),
              ),
              const SizedBox(height: 24),

              PlatformButton(
                text: 'Verify',
                onPressed: _verifyOTP,
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
      ),
    );
  }

  Widget _buildOtpField(int index) {
    return SizedBox(
      width: 50,
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
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (value) {
          if (value.length == 1 && index < 3) {
            _focusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus();
          } else if (value.length == 1 && index == 3) {
            _verifyOTP();
          }
        },
      ),
    );
  }
}
