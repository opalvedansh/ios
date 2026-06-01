import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zepwash_common/zepwash_common.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/neu_card.dart';

/// Widget displaying customer's current subscription plan
class PlanCard extends ConsumerWidget {
  final Customer customer;

  const PlanCard({super.key, required this.customer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isActive = customer.subscriptionStatus == 'active';
    final isOverdue = customer.subscriptionStatus == 'overdue';
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final statusColor = isActive
        ? (isDark ? AppTheme.darkSuccess : AppTheme.success)
        : isOverdue
            ? (isDark ? AppTheme.darkWarning : AppTheme.warning)
            : (isDark ? AppTheme.darkError : AppTheme.error);

    return NeuCard(
      onTap: () => context.push('/subscription'),
      isActive: isActive,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status row
          Row(
            children: [
              Icon(
                isActive
                    ? Icons.check_circle
                    : isOverdue
                        ? Icons.warning
                        : Icons.cancel,
                color: statusColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                _getStatusText(customer.subscriptionStatus),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: statusColor,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.chevron_right,
                color: isDark
                    ? AppTheme.darkTextSecondary
                    : AppTheme.textSecondary,
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Plan name
          if (customer.currentPlanId != null) ...[
            Text(
              'Monthly Plan - ${_formatVehicleType(customer.vehicleType)}',
              style: AppTheme.resolvedHeading3(context),
            ),
            const SizedBox(height: 8),
          ],

          // Vehicle info
          Row(
            children: [
              Icon(
                Icons.directions_car,
                size: 16,
                color: isDark
                    ? AppTheme.darkTextSecondary
                    : AppTheme.textSecondary,
              ),
              const SizedBox(width: 8),
              Text(
                '${customer.vehicleModel} • ${customer.plateCode}',
                style: AppTheme.resolvedBodyMedium(context).copyWith(
                  color: isDark
                      ? AppTheme.darkTextSecondary
                      : AppTheme.textSecondary,
                ),
              ),
            ],
          ),

          // Subscription ID if active
          if (customer.activeSubscriptionId != null) ...[
            const SizedBox(height: 8),
            Text(
              'ID: ${customer.activeSubscriptionId}',
              style: AppTheme.resolvedBodySmall(context),
            ),
          ],

          // Show subscribe button if not active
          if (!isActive && !isOverdue) ...[
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => context.push('/subscription'),
                child: const Text('Subscribe Now'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'active':
        return 'Active Subscription';
      case 'cancelled':
        return 'Cancelled';
      case 'overdue':
        return 'Payment Overdue';
      case 'inactive':
        return 'No Active Plan';
      default:
        return status;
    }
  }

  String _formatVehicleType(String type) {
    switch (type) {
      case 'sedan':
        return 'Sedan';
      case 'suv':
        return 'SUV';
      case 'hatchback':
        return 'Hatchback';
      case 'luxury':
        return 'Luxury';
      default:
        return type[0].toUpperCase() + type.substring(1);
    }
  }
}
