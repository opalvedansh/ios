import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// Platform-aware loading indicator
class PlatformLoadingIndicator extends StatelessWidget {
  final double? size;

  const PlatformLoadingIndicator({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {
      return CupertinoActivityIndicator(
        radius: size ?? 10,
      );
    }

    return SizedBox(
      width: size != null ? size! * 2 : 20,
      height: size != null ? size! * 2 : 20,
      child: const CircularProgressIndicator(strokeWidth: 2),
    );
  }
}

/// Full screen loading overlay
class PlatformLoadingOverlay extends StatelessWidget {
  final String? message;

  const PlatformLoadingOverlay({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const PlatformLoadingIndicator(size: 20),
                if (message != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    message!,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
