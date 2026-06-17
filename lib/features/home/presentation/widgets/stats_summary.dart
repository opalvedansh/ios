import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zepwash_common/zepwash_common.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/neu_card.dart';
import '../../../subscription/providers/subscription_provider.dart';

/// Widget displaying customer's monthly statistics
class StatsSummary extends ConsumerWidget {
  final Customer customer;

  const StatsSummary({super.key, required this.customer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subscriptionId = customer.activeSubscriptionId;

    if (subscriptionId == null) {
      return const SizedBox.shrink();
    }

    final subscriptionAsync =
        ref.watch(subscriptionStreamProvider(subscriptionId));

    return NeuCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'This Month',
            style: AppTheme.resolvedHeading3(context),
          ),
          const SizedBox(height: 16),

          subscriptionAsync.when(
            data: (subscription) {
              if (subscription == null) {
                return const Text('No subscription data');
              }

              return Row(
                children: [
                  Expanded(
                    child: _buildStatItem(
                      icon: Icons.check_circle,
                      label: 'Cleaned',
                      value: subscription.currentCycleCleaned.toString(),
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppTheme.darkSuccess
                          : AppTheme.success,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatItem(
                      icon: Icons.water_drop,
                      label: 'Litres Saved',
                      value:
                          (18 * subscription.currentCycleCleaned).toString(),
                      color: Colors.blue.shade400,
                    ),
                  ),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) => Text('Error: $e'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: color),
          ),
        ],
      ),
    );
  }
}
