import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:zepwash_common/zepwash_common.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/providers/theme_provider.dart';
import '../../../../shared/widgets/platform_scaffold.dart';
import '../../../../shared/widgets/platform_alert.dart';
import '../../../../shared/widgets/platform_loading.dart';
import '../../../../shared/widgets/neu_card.dart';
import '../../../../shared/widgets/gradient_scaffold.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../home/providers/customer_provider.dart';

/// Profile and settings screen
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profilesAsync = ref.watch(customerProfilesProvider);
    final customer = ref.watch(selectedCustomerProvider);
    final userAsync = ref.watch(userDataProvider);
    final themeMode = ref.watch(themeModeProvider);
    final isDark = themeMode == ThemeMode.dark;

    return PlatformScaffold(
      title: 'Profile',
      actions: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: IconButton(
            key: ValueKey(isDark),
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            tooltip: isDark ? 'Switch to light mode' : 'Switch to dark mode',
            onPressed: () => ref.read(themeModeProvider.notifier).toggle(),
          ),
        ),
      ],
      body: GradientScaffold(
        child: profilesAsync.when(
          loading: () => const Center(child: PlatformLoadingIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
          data: (_) => userAsync.when(
            loading: () => const Center(child: PlatformLoadingIndicator()),
            error: (error, stack) => Center(child: Text('Error: $error')),
            data: (User? user) {
              if (user == null) {
                return const Center(child: Text('User data not found'));
              }
              return Builder(builder: (context) {
                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    // Personal Information Section
                    _buildSectionTitle(context, 'Personal Information'),
                    _buildInfoCard(context, [
                      _buildInfoTile(
                        context: context,
                        icon: Icons.person_outline,
                        label: 'Name',
                        value: user.name,
                      ),
                      Divider(
                        height: 1,
                        color: isDark
                            ? AppTheme.darkShadowLight.withValues(alpha: 0.3)
                            : Colors.grey.shade200,
                      ),
                      _buildInfoTile(
                        context: context,
                        icon: Icons.phone_outlined,
                        label: 'Mobile Number',
                        value: user.phone,
                      ),
                    ]),
                    const SizedBox(height: 24),

                    // Service Address Section
                    if (customer != null) ...[
                      _buildSectionTitle(context, 'Service Address'),
                      _buildInfoCard(context, [
                        _buildInfoTile(
                          context: context,
                          icon: Icons.location_on_outlined,
                          label: 'Address',
                          value: customer.address,
                        ),
                      ]),
                      const SizedBox(height: 24),

                      // Vehicle Details Section
                      _buildSectionTitle(context, 'Vehicle Details'),
                      _buildInfoCard(context, [
                        _buildInfoTile(
                          context: context,
                          icon: Icons.directions_car_outlined,
                          label: 'Model',
                          value: customer.vehicleModel,
                        ),
                        Divider(
                          height: 1,
                          color: isDark
                              ? AppTheme.darkShadowLight.withValues(alpha: 0.3)
                              : Colors.grey.shade200,
                        ),
                        _buildInfoTile(
                          context: context,
                          icon: Icons.numbers_outlined,
                          label: 'Plate Code',
                          value: customer.plateCode,
                        ),
                        Divider(
                          height: 1,
                          color: isDark
                              ? AppTheme.darkShadowLight.withValues(alpha: 0.3)
                              : Colors.grey.shade200,
                        ),
                        _buildInfoTile(
                          context: context,
                          icon: Icons.category_outlined,
                          label: 'Vehicle Type',
                          value: customer.vehicleType.toUpperCase(),
                        ),
                      ]),
                      const SizedBox(height: 32),
                    ],

                    // Edit Note
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'For any edits, refer to Complaints section',
                        textAlign: TextAlign.center,
                        style: AppTheme.resolvedBodySmall(context).copyWith(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Logout button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: OutlinedButton.icon(
                        onPressed: () => _handleLogout(context, ref),
                        icon: Icon(
                          Icons.logout,
                          color: isDark ? AppTheme.darkError : AppTheme.error,
                        ),
                        label: Text(
                          'Logout',
                          style: TextStyle(
                            color: isDark ? AppTheme.darkError : AppTheme.error,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: isDark ? AppTheme.darkError : AppTheme.error,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Delete Account button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TextButton.icon(
                        onPressed: () => _handleDeleteAccount(context, ref),
                        icon: const Icon(
                          Icons.delete_forever_outlined,
                          color: Colors.red,
                        ),
                        label: const Text(
                          'Delete Account',
                          style: TextStyle(color: Colors.red),
                        ),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                );
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8),
      child: Text(
        title,
        style: AppTheme.resolvedHeading3(context).copyWith(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppTheme.darkPrimary
              : AppTheme.primary,
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, List<Widget> children) {
    return NeuCard(
      padding: 0,
      borderRadius: 12,
      child: Column(children: children),
    );
  }

  Widget _buildInfoTile({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: isDark ? AppTheme.darkTextSecondary : AppTheme.textSecondary,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTheme.resolvedBodySmall(context).copyWith(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value.isEmpty ? 'Not specified' : value,
                  style: AppTheme.resolvedBodyMedium(context).copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleLogout(BuildContext context, WidgetRef ref) async {
    final confirmed = await showPlatformAlert(
      context: context,
      title: 'Logout',
      content: 'Are you sure you want to logout?',
      confirmText: 'Logout',
      cancelText: 'Cancel',
      isDestructive: true,
    );

    if (confirmed == true && context.mounted) {
      await ref.read(authServiceProvider).signOut();
      if (context.mounted) {
        context.go('/auth/phone');
      }
    }
  }

  Future<void> _handleDeleteAccount(BuildContext context, WidgetRef ref) async {
    // First confirmation: warn the user
    final firstConfirm = await showPlatformAlert(
      context: context,
      title: 'Delete Account',
      content:
          'This will permanently delete your account and all associated data — '
          'subscription, cleanings, complaints, and payments. '
          'This action cannot be undone.',
      confirmText: 'Continue',
      cancelText: 'Cancel',
      isDestructive: true,
    );
    if (firstConfirm != true || !context.mounted) return;

    // Second confirmation: final irreversible step
    final secondConfirm = await showPlatformAlert(
      context: context,
      title: 'Are you absolutely sure?',
      content: 'Your account will be permanently deleted and you will be logged out immediately.',
      confirmText: 'Permanently Delete',
      cancelText: 'Cancel',
      isDestructive: true,
    );
    if (secondConfirm != true || !context.mounted) return;

    // Show loading state while deleting
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: PlatformLoadingIndicator()),
    );

    try {
      final uid = ref.read(currentUserIdProvider);
      if (uid == null) throw Exception('Not authenticated');

      final functions = FirebaseFunctions.instanceFor(region: 'asia-south1');
      final result = await functions
          .httpsCallable('deleteCustomerAccount')
          .call({'customerId': uid});

      final data = result.data as Map<String, dynamic>;
      if (data['success'] != true) {
        throw Exception(data['message'] ?? 'Deletion failed');
      }

      // Sign out locally (Auth user already deleted server-side)
      await ref.read(authServiceProvider).signOut();

      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).pop(); // dismiss loader
        context.go('/auth/phone');
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).pop(); // dismiss loader
        showPlatformError(context, 'Failed to delete account. Please try again.');
      }
    }
  }
}
