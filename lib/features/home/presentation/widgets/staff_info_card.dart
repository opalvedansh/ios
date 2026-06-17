import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/neu_card.dart';
import '../../providers/customer_provider.dart';

/// Widget displaying area supervisor contact information
class SupervisorInfoCard extends StatelessWidget {
  final SupervisorInfo? supervisor;

  const SupervisorInfoCard({super.key, this.supervisor});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? AppTheme.darkPrimary : AppTheme.primary;
    final successColor = isDark ? AppTheme.darkSuccess : AppTheme.success;
    final secondaryTextColor =
        isDark ? AppTheme.darkTextSecondary : AppTheme.textSecondary;

    if (supervisor == null || supervisor!.phone.isEmpty) {
      return NeuCard(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.support_agent_outlined,
                size: 48,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Subscription Active',
              style: AppTheme.resolvedHeading3(context),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Your subscription is active. Contact support if you need help.',
              style: AppTheme.resolvedBodyMedium(context).copyWith(
                color: secondaryTextColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return NeuCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Area Supervisor',
            style: AppTheme.resolvedHeading3(context),
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              // Supervisor avatar
              CircleAvatar(
                radius: 32,
                backgroundColor: primaryColor.withValues(alpha: 0.1),
                child: Text(
                  supervisor!.name.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Supervisor info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      supervisor!.name,
                      style: AppTheme.resolvedBodyLarge(context).copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.phone,
                            size: 14, color: secondaryTextColor),
                        const SizedBox(width: 4),
                        Text(
                          supervisor!.phone,
                          style: AppTheme.resolvedBodySmall(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Call button
              IconButton(
                onPressed: () => _callSupervisor(supervisor!.phone),
                icon: Icon(Icons.phone, color: successColor),
                style: IconButton.styleFrom(
                  backgroundColor: successColor.withValues(alpha: 0.1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _callSupervisor(String phoneNumber) async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
