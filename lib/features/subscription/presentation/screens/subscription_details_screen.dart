import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zepwash_common/zepwash_common.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/platform_loading.dart';
import '../../../../shared/widgets/platform_scaffold.dart';
import '../../../../shared/widgets/gradient_scaffold.dart';
import '../../../home/providers/customer_provider.dart';

/// Subscription details screen showing plan info, other available plans, and cancel option
class SubscriptionDetailsScreen extends ConsumerWidget {
  const SubscriptionDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profilesAsync = ref.watch(customerProfilesProvider);
    final customer = ref.watch(selectedCustomerProvider);

    return PlatformScaffold(
      title: 'Subscription',
      body: GradientScaffold(
        child: profilesAsync.when(
          loading: () => const Center(child: PlatformLoadingIndicator()),
          error: (e, st) => Center(child: Text('Error: $e')),
          data: (_) {
            if (customer == null) {
              return const Center(child: Text('No subscription found.'));
            }
            return _SubscriptionDetailsBody(customer: customer);
          },
        ),
      ),
    );
  }
}

class _SubscriptionDetailsBody extends ConsumerWidget {
  final Customer customer;

  const _SubscriptionDetailsBody({required this.customer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final areaAsync = ref.watch(customerAreaProvider);
    final isActive = customer.subscriptionStatus == 'active';
    final isOverdue = customer.subscriptionStatus == 'overdue';

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(customerProfilesProvider);
        ref.invalidate(customerAreaProvider);
      },
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Current subscription details
          _buildDetailsCard(context, customer),
          const SizedBox(height: 24),

          // Cancel subscription at the bottom
          if (isActive || isOverdue) ...[
            const SizedBox(height: 32),
            _buildCancelSection(context, ref),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailsCard(BuildContext context, Customer customer) {
    final isActive = customer.subscriptionStatus == 'active';
    final isOverdue = customer.subscriptionStatus == 'overdue';
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final statusColor = isActive
        ? (isDark ? AppTheme.darkSuccess : AppTheme.success)
        : isOverdue
            ? (isDark ? AppTheme.darkWarning : AppTheme.warning)
            : (isDark ? AppTheme.darkError : AppTheme.error);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  _statusText(customer.subscriptionStatus),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            _buildDetailRow(
              context,
              Icons.star,
              'Plan',
              'Monthly - ${_formatVehicleType(customer.vehicleType)}',
            ),
            const SizedBox(height: 12),
            _buildDetailRow(
              context,
              Icons.directions_car,
              'Vehicle',
              '${customer.vehicleModel} • ${customer.plateCode}',
            ),
            if (customer.activeSubscriptionId != null) ...[
              const SizedBox(height: 12),
              _buildDetailRow(
                context,
                Icons.receipt_long,
                'Subscription ID',
                customer.activeSubscriptionId!,
              ),
            ],
            if (customer.currentPeriodEnd != null) ...[
              const SizedBox(height: 12),
              _buildDetailRow(
                context,
                Icons.calendar_today,
                'Next Billing',
                Formatters.date(customer.currentPeriodEnd!),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: AppTheme.resolvedTextSecondaryColor(context)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTheme.resolvedCaption(context),
              ),
              const SizedBox(height: 2),
              Text(value, style: AppTheme.resolvedBodyMedium(context)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCancelSection(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const Divider(),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => _confirmCancel(context, ref),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.error,
              side: const BorderSide(color: AppTheme.error),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Cancel Subscription'),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Service will continue until the end of your current billing period.',
          style: AppTheme.resolvedCaption(context),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Future<void> _confirmCancel(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Subscription'),
        content: const Text(
          'Are you sure you want to cancel? Your service will continue until the end of the current billing period.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Keep Subscription'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppTheme.error),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    try {
      await FirebaseFunctions.instanceFor(region: 'asia-south1')
          .httpsCallable('cancelSubscription')
          .call({
        'customerId': customer.id,
      });

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Subscription cancelled. You can subscribe again anytime.'),
            backgroundColor: AppTheme.success,
          ),
        );
        context.go('/home');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to cancel: $e'),
            backgroundColor: AppTheme.error,
          ),
        );
      }
    }
  }

  String _statusText(String status) {
    switch (status) {
      case 'active':
        return 'Active Subscription';
      case 'cancelled':
        return 'Cancelled';
      case 'overdue':
        return 'Payment Overdue';
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

class _OtherPlansSection extends StatelessWidget {
  final Customer customer;
  final Area area;

  const _OtherPlansSection({required this.customer, required this.area});

  @override
  Widget build(BuildContext context) {
    final otherTypes = area.pricing.keys
        .where((type) => type != customer.vehicleType)
        .toList();

    if (otherTypes.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Explore Other Plans', style: AppTheme.resolvedHeading3(context)),
        const SizedBox(height: 4),
        Text(
          'Switch to a plan that suits another vehicle',
          style: AppTheme.resolvedBodySmall(context),
        ),
        const SizedBox(height: 16),
        ...otherTypes.map((type) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildPlanCard(context, type),
            )),
      ],
    );
  }

  Widget _buildPlanCard(BuildContext context, String vehicleType) {
    final pricing = area.pricing[vehicleType];
    if (pricing == null) return const SizedBox.shrink();

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(_vehicleIcon(vehicleType),
                    size: 32, color: AppTheme.resolvedPrimaryColor(context)),
                const SizedBox(width: 12),
                Text(_formatVehicleType(vehicleType),
                    style: AppTheme.resolvedHeading3(context)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  Formatters.currency(pricing.monthly / 100),
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.resolvedPrimaryColor(context),
                  ),
                ),
                Text(
                  '/month',
                  style: AppTheme.resolvedBodySmall(context),
                ),
                const Spacer(),
                Text(
                  '${Formatters.currency(pricing.dailyRate / 100)}/day',
                  style: AppTheme.resolvedBodySmall(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildFeature(context, 'Daily professional car wash'),
            _buildFeature(context, 'Doorstep service'),
            _buildFeature(context, 'Experienced staff'),
            _buildFeature(context, 'Photo proof of cleaning'),
          ],
        ),
      ),
    );
  }

  Widget _buildFeature(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(Icons.check_circle, size: 20, color: AppTheme.success),
          const SizedBox(width: 8),
          Text(text, style: AppTheme.resolvedBodyMedium(context)),
        ],
      ),
    );
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

  IconData _vehicleIcon(String type) {
    if (type == 'suv') return Icons.directions_car_filled;
    return Icons.directions_car;
  }
}
