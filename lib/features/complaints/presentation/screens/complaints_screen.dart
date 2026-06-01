import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/platform_scaffold.dart';
import '../../../../shared/widgets/gradient_scaffold.dart';
import '../../../../core/theme/app_theme.dart';
import '../../providers/complaint_provider.dart';
import '../widgets/complaint_card.dart';

/// Complaints list screen
class ComplaintsScreen extends ConsumerWidget {
  const ComplaintsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final complaintsAsync = ref.watch(customerComplaintsProvider);

    return PlatformScaffold(
      title: 'Complaints',
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => context.push('/complaints/create'),
        ),
      ],
      body: GradientScaffold(
        child: complaintsAsync.when(
          data: (complaints) {
            if (complaints.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.inbox_outlined,
                      size: 80,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppTheme.darkTextSecondary
                          : AppTheme.textSecondary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No complaints yet',
                      style: AppTheme.resolvedHeading3(context),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'If you have any issues, feel free to report them.',
                      style: AppTheme.resolvedBodyMedium(context),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => context.push('/complaints/create'),
                      icon: const Icon(Icons.add),
                      label: const Text('Create Complaint'),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: complaints.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Complaints',
                        style: AppTheme.resolvedHeading2(context),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Track your complaints and their resolution status.',
                        style: AppTheme.resolvedBodyMedium(context),
                      ),
                      const SizedBox(height: 24),
                    ],
                  );
                }
                return ComplaintCard(complaint: complaints[index - 1]);
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 60, color: Colors.red),
                const SizedBox(height: 16),
                Text('Error loading complaints: $error'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => ref.refresh(customerComplaintsProvider),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
