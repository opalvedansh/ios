import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:zepwash_common/models/cleaning.dart';
import '../../../../shared/widgets/platform_scaffold.dart';
import '../../../../shared/widgets/gradient_scaffold.dart';
import '../../../../core/theme/app_theme.dart';
import '../../providers/cleaning_provider.dart';

/// Attendance screen showing cleaning history for the last 7 days
class AttendanceScreen extends ConsumerStatefulWidget {
  const AttendanceScreen({super.key});

  @override
  ConsumerState<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends ConsumerState<AttendanceScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = ref.watch(selectedDateProvider);
    final cleaningAsync = ref.watch(cleaningProvider);

    final now = DateTime.now();
    final dates = List.generate(7, (index) {
      return now.subtract(Duration(days: index));
    }).reversed.toList();

    return PlatformScaffold(
      title: 'Cleaning History',
      body: GradientScaffold(
        child: Column(
          children: [
            _buildDatePicker(context, dates, selectedDate),
            Expanded(
              child: cleaningAsync.when(
                data: (cleaning) =>
                    _buildCleaningDetails(context, cleaning, selectedDate),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text('Error: $err')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker(
    BuildContext context,
    List<DateTime> dates,
    DateTime selectedDate,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkSurface : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final date = dates[index];
          final isSelected = isSameDay(date, selectedDate);
          final isToday = isSameDay(date, DateTime.now());
          final accentColor =
              isDark ? AppTheme.darkPrimary : AppTheme.primary;

          return GestureDetector(
            onTap: () =>
                ref.read(selectedDateProvider.notifier).state = date,
            child: Container(
              width: 60,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: isSelected
                    ? accentColor
                    : isDark
                        ? AppTheme.darkSurfaceElevated
                        : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected
                      ? accentColor
                      : isDark
                          ? AppTheme.darkShadowLight.withOpacity(0.4)
                          : Colors.grey.shade200,
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('E').format(date),
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : isDark
                              ? AppTheme.darkTextSecondary
                              : Colors.grey.shade600,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('d').format(date),
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : isDark
                              ? AppTheme.darkTextPrimary
                              : Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  if (isToday)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.white : accentColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCleaningDetails(
    BuildContext context,
    Cleaning? cleaning,
    DateTime selectedDate,
  ) {
    final isToday = isSameDay(selectedDate, DateTime.now());

    if (cleaning == null) {
      if (isToday) {
        return _buildStatusView(
          context,
          icon: Icons.schedule,
          color: Colors.blue,
          title: 'Cleaning Scheduled',
          subtitle: 'Our staff will arrive soon for today\'s cleaning.',
        );
      } else {
        return _buildStatusView(
          context,
          icon: Icons.event_busy,
          color: Colors.grey,
          title: 'No Data Available',
          subtitle: 'No cleaning was scheduled or recorded for this date.',
        );
      }
    }

    switch (cleaning.status) {
      case 'completed':
        return _buildCompletedView(context, cleaning);
      case 'missed':
        return _buildStatusView(
          context,
          icon: Icons.error_outline,
          color: Colors.red,
          title: 'Cleaning Missed',
          subtitle:
              'Unfortunately, the cleaning was missed for this date. A ticket has been raised.',
        );
      case 'pending':
        return _buildStatusView(
          context,
          icon: Icons.schedule,
          color: Colors.orange,
          title: 'Cleaning Pending',
          subtitle: isToday
              ? 'Our staff will arrive soon for today\'s cleaning.'
              : 'The cleaning was not completed on this date.',
        );
      default:
        return _buildStatusView(
          context,
          icon: Icons.help_outline,
          color: Colors.grey,
          title: 'Unknown Status',
          subtitle: 'The cleaning status is unknown.',
        );
    }
  }

  Widget _buildCompletedView(BuildContext context, Cleaning cleaning) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final placeholderColor =
        isDark ? AppTheme.darkSurfaceElevated : Colors.grey.shade100;
    final placeholderIconColor =
        isDark ? AppTheme.darkTextSecondary : Colors.grey;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatusCard(
            icon: Icons.check_circle,
            color: Colors.green,
            status: 'Completed',
            time: cleaning.completedAt != null
                ? DateFormat('hh:mm a').format(cleaning.completedAt!)
                : 'N/A',
          ),
          const SizedBox(height: 24),
          Text(
            'Service Proof',
            style: AppTheme.resolvedHeading3(context),
          ),
          const SizedBox(height: 12),
          if (cleaning.photoUrl != null && cleaning.photoUrl!.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: cleaning.photoUrl!,
                placeholder: (context, url) => Container(
                  height: 300,
                  color: placeholderColor,
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 300,
                  color: placeholderColor,
                  child: Icon(Icons.error_outline,
                      size: 48, color: placeholderIconColor),
                ),
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            )
          else
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: placeholderColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isDark
                      ? AppTheme.darkShadowLight.withOpacity(0.4)
                      : Colors.grey.shade200,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.no_photography_outlined,
                      size: 48, color: placeholderIconColor),
                  const SizedBox(height: 12),
                  Text(
                    'No photo proof uploaded',
                    style: AppTheme.resolvedBodyMedium(context),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStatusCard({
    required IconData icon,
    required Color color,
    required String status,
    required String time,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                status,
                style: TextStyle(
                  color: color,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Finished at $time',
                style: TextStyle(
                  color: color.withOpacity(0.8),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusView(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 64, color: color),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: AppTheme.resolvedHeading2(context).copyWith(color: color),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            subtitle,
            style: AppTheme.resolvedBodyMedium(context),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
