import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_theme.dart';

/// Platform-aware text field that adapts to iOS and Android
class PlatformTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int? maxLines;
  final int? maxLength;
  final Widget? prefix;
  final Widget? suffix;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final VoidCallback? onTap;
  final Function(String)? onChanged;

  const PlatformTextField({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines = 1,
    this.maxLength,
    this.prefix,
    this.suffix,
    this.inputFormatters,
    this.enabled = true,
    this.onTap,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null) ...[
            Text(
              label!,
              style: TextStyle(
                fontSize: 13,
                color: isDark ? AppTheme.darkTextSecondary : CupertinoColors.secondaryLabel,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
          ],
          CupertinoTextField(
            controller: controller,
            placeholder: hint,
            placeholderStyle: AppTheme.resolvedBodyLarge(context).copyWith(
              color: isDark ? AppTheme.darkTextSecondary : AppTheme.textSecondary,
            ),
            keyboardType: keyboardType,
            obscureText: obscureText,
            maxLines: maxLines,
            maxLength: maxLength,
            prefix: prefix != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: prefix,
                  )
                : null,
            suffix: suffix != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: suffix,
                  )
                : null,
            inputFormatters: inputFormatters,
            enabled: enabled,
            onTap: onTap,
            onChanged: onChanged,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isDark ? AppTheme.darkSurfaceElevated : CupertinoColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark 
                    ? AppTheme.darkShadowLight.withOpacity(0.4) 
                    : CupertinoColors.systemGrey4,
              ),
            ),
            style: AppTheme.resolvedBodyLarge(context),
          ),
        ],
      );
    }

    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefix: prefix,
        suffixIcon: suffix,
        counterText: maxLength != null ? null : '',
        // Maintain theme defaults but allow manual enabled control
        enabled: enabled,
      ),
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      readOnly: !enabled,
      style: AppTheme.resolvedBodyLarge(context),
      onTap: onTap,
      onChanged: onChanged,
    );
  }
}
