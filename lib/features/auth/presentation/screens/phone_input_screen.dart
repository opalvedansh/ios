import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:zepwash_common/zepwash_common.dart';
import '../../../../core/services/phone_auth_handler.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/platform_scaffold.dart';
import '../../../../shared/widgets/platform_text_field.dart';
import '../../../../shared/widgets/platform_button.dart';
import '../../../../shared/widgets/platform_alert.dart';

class PhoneInputScreen extends StatefulWidget {
  const PhoneInputScreen({super.key});

  @override
  State<PhoneInputScreen> createState() => _PhoneInputScreenState();
}

class _PhoneInputScreenState extends State<PhoneInputScreen> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _sendOTP() async {
    if (!_formKey.currentState!.validate()) return;

    final digits = _phoneController.text.trim();
    // MSG91 expects country code without +: 91XXXXXXXXXX
    final phoneForMsg91 = '91$digits';

    setState(() => _isLoading = true);

    try {
      final reqId = await PhoneAuthHandler.sendOTP(phoneForMsg91);
      if (!mounted) return;
      setState(() => _isLoading = false);
      context.go('/auth/otp', extra: {
        'phone': '+91$digits',
        'reqId': reqId,
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      showPlatformError(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      showBackButton: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),

                const Icon(
                  Icons.local_car_wash,
                  size: 80,
                  color: AppTheme.primary,
                ),
                const SizedBox(height: 32),

                Text(
                  'Welcome to ZepWash',
                  style: AppTheme.resolvedHeading2(context),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),

                Text(
                  'Enter your phone number to continue',
                  style: AppTheme.resolvedBodyMedium(context).copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppTheme.darkTextSecondary
                        : AppTheme.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),

                PlatformTextField(
                  controller: _phoneController,
                  label: 'Phone Number',
                  hint: '9876543210',
                  keyboardType: TextInputType.phone,
                  prefix: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      '+91',
                      style: AppTheme.resolvedBodyLarge(context),
                    ),
                  ),
                  maxLength: 10,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (value.length != 10) {
                      return 'Phone number must be 10 digits';
                    }
                    final phoneError = Validators.phone(value);
                    if (phoneError != null) return phoneError;
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                PlatformButton(
                  text: 'Send OTP',
                  onPressed: _sendOTP,
                  isLoading: _isLoading,
                ),

                const Spacer(flex: 2),

                Text(
                  'By continuing, you agree to our Terms of Service and Privacy Policy',
                  style: AppTheme.resolvedBodySmall(context),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
