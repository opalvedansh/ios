import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:zepwash_common/zepwash_common.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/platform_scaffold.dart';
import '../../../../shared/widgets/platform_loading.dart';
import '../../../../shared/widgets/gradient_scaffold.dart';
import '../../providers/customer_provider.dart';
import '../widgets/plan_card.dart';
import '../widgets/plan_selection_view.dart';
import '../widgets/staff_info_card.dart' show SupervisorInfoCard;
import '../widgets/stats_summary.dart';

const _maxVehicles = 3;

/// Home screen showing customer dashboard
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  void _onNavigationTap(int index) {
    setState(() => _selectedIndex = index);

    switch (index) {
      case 0:
        break;
      case 1:
        context.push('/attendance').then((_) {
          if (mounted) setState(() => _selectedIndex = 0);
        });
        break;
      case 2:
        context.push('/complaints').then((_) {
          if (mounted) setState(() => _selectedIndex = 0);
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final profilesAsync = ref.watch(customerProfilesProvider);
    final customer = ref.watch(selectedCustomerProvider);
    final supervisorAsync = ref.watch(areaSupervisorProvider);

    final isSubscribed = customer?.subscriptionStatus == 'active';

    if (!isSubscribed && _selectedIndex != 0) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _selectedIndex = 0);
      });
    }

    return PlatformScaffold(
      titleWidget: SvgPicture.asset(
        'assets/images/header_logo.svg',
        height: 144,
        fit: BoxFit.contain,
      ),
      showBackButton: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.person),
          onPressed: () => context.push('/profile'),
        ),
      ],
      body: GradientScaffold(
        child: profilesAsync.when(
          loading: () => const Center(child: PlatformLoadingIndicator()),
          error: (error, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: AppTheme.error),
                const SizedBox(height: 16),
                Text('Error: $error'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => ref.invalidate(customerProfilesProvider),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
          data: (profiles) {
            if (profiles.isEmpty || customer == null || customer.subscriptionStatus != 'active') {
              return _buildPreSubscriptionHome(profiles.length);
            }

            return RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(customerProfilesProvider);
                ref.invalidate(areaSupervisorProvider);
              },
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // ── Vehicle Switcher ────────────────────────────────────
                  if (profiles.isNotEmpty)
                    _VehicleSwitcher(profiles: profiles),
                  const SizedBox(height: 16),

                  // Welcome message
                  Text(
                    'Welcome back!',
                    style: AppTheme.resolvedHeading2(context),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Manage your car wash subscription',
                    style: AppTheme.resolvedBodyMedium(context).copyWith(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppTheme.darkTextSecondary
                          : AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Active Plan Card
                  PlanCard(customer: customer),
                  const SizedBox(height: 16),

                  // Supervisor Info
                  supervisorAsync.when(
                    data: (supervisor) =>
                        SupervisorInfoCard(supervisor: supervisor),
                    loading: () => const Card(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: Center(child: PlatformLoadingIndicator()),
                      ),
                    ),
                    error: (e, st) => Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text('Error loading supervisor: $e'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Monthly Stats
                  if (customer.subscriptionStatus == 'active')
                    StatsSummary(customer: customer),
                  const SizedBox(height: 16),

                  // Next Billing
                  if (customer.currentPeriodEnd != null)
                    _buildBillingCard(context, customer.currentPeriodEnd!),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: isSubscribed
          ? NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onNavigationTap,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.calendar_month_outlined),
                  selectedIcon: Icon(Icons.calendar_month),
                  label: 'Attendance',
                ),
                NavigationDestination(
                  icon: Icon(Icons.report_problem_outlined),
                  selectedIcon: Icon(Icons.report_problem),
                  label: 'Complaints',
                ),
              ],
            )
          : null,
    );
  }

  Widget _buildBillingCard(BuildContext context, DateTime nextBilling) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final daysUntil = nextBilling.difference(DateTime.now()).inDays;
    final accentColor = isDark ? AppTheme.darkPrimary : AppTheme.primary;

    return Container(
      decoration: BoxDecoration(
        color: accentColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.calendar_today, color: accentColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Next Billing', style: AppTheme.resolvedBodySmall(context)),
                const SizedBox(height: 4),
                Text(
                  daysUntil > 0
                      ? '$daysUntil days away'
                      : daysUntil == 0
                          ? 'Today'
                          : 'Overdue',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: accentColor,
                  ),
                ),
              ],
            ),
          ),
          Text(Formatters.date(nextBilling), style: AppTheme.resolvedBodySmall(context)),
        ],
      ),
    );
  }

  Widget _buildPreSubscriptionHome(int existingCount) {
    return Column(
      children: [
        if (existingCount > 0)
          Consumer(builder: (context, ref, _) {
            final profiles = ref.watch(customerProfilesProvider).value ?? [];
            return _VehicleSwitcher(profiles: profiles);
          }),
        const Expanded(child: PlanSelectionView()),
      ],
    );
  }
}

/// Horizontal chip row for switching between vehicle profiles
class _VehicleSwitcher extends ConsumerWidget {
  final List<Customer> profiles;
  const _VehicleSwitcher({required this.profiles});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedId = ref.watch(selectedCustomerIdProvider);
    final activeId = selectedId ?? (profiles.isNotEmpty ? profiles.first.id : null);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accentColor = isDark ? AppTheme.darkPrimary : AppTheme.primary;
    final canAddMore = profiles.length < _maxVehicles;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...profiles.map((p) {
            final isSelected = p.id == activeId;
            final label = p.label?.isNotEmpty == true
                ? p.label!
                : p.plateCode.isNotEmpty
                    ? p.plateCode
                    : p.vehicleType;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(label),
                selected: isSelected,
                selectedColor: accentColor.withOpacity(0.2),
                labelStyle: TextStyle(
                  color: isSelected ? accentColor : null,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                side: isSelected
                    ? BorderSide(color: accentColor, width: 1.5)
                    : null,
                onSelected: (_) {
                  ref.read(selectedCustomerIdProvider.notifier).state = p.id;
                },
              ),
            );
          }),
          // Add vehicle button
          ActionChip(
            avatar: Icon(
              Icons.add,
              size: 16,
              color: canAddMore ? accentColor : Colors.grey,
            ),
            label: Text(
              'Add vehicle',
              style: TextStyle(color: canAddMore ? accentColor : Colors.grey),
            ),
            side: BorderSide(color: canAddMore ? accentColor : Colors.grey),
            backgroundColor: Colors.transparent,
            onPressed: canAddMore
                ? () => context.push('/home/add-vehicle')
                : () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Maximum 3 vehicles allowed per account'),
                      ),
                    );
                  },
          ),
        ],
      ),
    );
  }
}
