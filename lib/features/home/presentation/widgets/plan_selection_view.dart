import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:zepwash_common/zepwash_common.dart' hide AppConstants;
import '../../../../core/constants/app_constants.dart';
import '../../../../core/providers/location_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/web_page_reload.dart';
import '../../../../shared/widgets/platform_loading.dart';

/// Widget showing available plans in pre-subscription state
class PlanSelectionView extends ConsumerStatefulWidget {
  const PlanSelectionView({super.key});

  @override
  ConsumerState<PlanSelectionView> createState() => _PlanSelectionViewState();
}

class _PlanSelectionViewState extends ConsumerState<PlanSelectionView> {
  Area? _selectedArea;
  AreaWithDistance? _selectedAreaWithDistance;

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      final result = await Geolocator.requestPermission();
      if (result == LocationPermission.whileInUse ||
          result == LocationPermission.always) {
        if (kIsWeb) {
          reloadPage();
        } else {
          _refreshLocationProviders();
        }
        return;
      }

      if (!kIsWeb &&
          (result == LocationPermission.denied ||
              result == LocationPermission.deniedForever) &&
          mounted) {
        _showLocationPermissionDialog();
      }
    } else if (permission == LocationPermission.deniedForever) {
      if (kIsWeb) {
        return;
      }

      if (mounted) {
        _showLocationPermissionDialog();
      }
    } else {
      _refreshLocationProviders();
    }
  }

  void _refreshLocationProviders() {
    ref.invalidate(currentPositionProvider);
    ref.invalidate(sortedAreasByDistanceProvider);
  }

  void _showLocationPermissionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Location Permission Required'),
        content: const Text(
          'We need your location to find car wash services available in your area. This is required to ensure we can provide service at your location. Please grant location permission to continue.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              if (!kIsWeb) {
                final result = await Geolocator.requestPermission();
                if (result == LocationPermission.whileInUse ||
                    result == LocationPermission.always) {
                  if (kIsWeb) {
                    reloadPage();
                  } else {
                    _refreshLocationProviders();
                  }
                } else if (result == LocationPermission.deniedForever) {
                  await Geolocator.openLocationSettings();
                } else if (result == LocationPermission.denied) {
                  // If still denied, ask again (recursive)
                  if (mounted) _requestLocationPermission();
                }
              }
            },
            child: const Text('Grant Permission'),
          ),
        ],
      ),
    );
  }

  String _formatDistance(double? meters) {
    if (meters == null) return '';
    if (meters < 1000) return '${meters.round()} m away';
    return '${(meters / 1000).toStringAsFixed(1)} km away';
  }

  void _openAreaPicker(List<AreaWithDistance> areas) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => _AreaPickerSheet(
        areas: areas,
        onAreaSelected: (awd) {
          setState(() {
            _selectedAreaWithDistance = awd;
            _selectedArea = awd.area;
          });
        },
      ),
    );
  }

  String _formatVehicleType(String vehicleType) {
    switch (vehicleType) {
      case 'hatchback':
        return 'Hatchback';
      case 'sedan':
        return 'Sedan';
      case 'suv':
        return 'SUV';
      default:
        return vehicleType;
    }
  }

  IconData _getVehicleIcon(String vehicleType) {
    switch (vehicleType) {
      case 'suv':
        return Icons.directions_car_filled;
      default:
        return Icons.directions_car;
    }
  }

  void _onSubscribeTap(String vehicleType, VehiclePricing pricing) {
    if (_selectedArea == null) return;

    context.push('/vehicle-details', extra: {
      'areaId': _selectedArea!.id,
      'vehicleType': vehicleType,
      'planId': pricing.planId,
      'monthlyPrice': pricing.monthly,
    });
  }

  @override
  Widget build(BuildContext context) {
    final sortedAreasAsync = ref.watch(sortedAreasByDistanceProvider);

    return SafeArea(
      child: Column(
        children: [
          // Welcome header
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome to ZepWash!', style: AppTheme.resolvedHeading2(context)),
                const SizedBox(height: 8),
                Text(
                  'Choose your subscription plan',
                  style: AppTheme.resolvedBodyMedium(context).copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppTheme.darkTextSecondary
                        : AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Area selector
          sortedAreasAsync.when(
            loading: () => const Padding(
              padding: EdgeInsets.all(24),
              child: PlatformLoadingIndicator(),
            ),
            error: (e, st) => _buildErrorWidget(e.toString()),
            data: (areas) {
              if (areas.isEmpty) return _buildNoAreasWidget();
              return _buildLocationField(areas);
            },
          ),

          // Plan cards
          if (_selectedArea != null)
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  if (_selectedArea!.pricing['hatchback'] != null)
                    _buildPlanCard('hatchback', _getVehicleIcon('hatchback')),
                  if (_selectedArea!.pricing['hatchback'] != null)
                    const SizedBox(height: 16),
                  if (_selectedArea!.pricing['sedan'] != null)
                    _buildPlanCard('sedan', _getVehicleIcon('sedan')),
                  if (_selectedArea!.pricing['sedan'] != null)
                    const SizedBox(height: 16),
                  if (_selectedArea!.pricing['suv'] != null)
                    _buildPlanCard('suv', _getVehicleIcon('suv')),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLocationField(List<AreaWithDistance> areas) {
    final label = _selectedArea?.name ?? 'Select your service area';
    final distText = _selectedAreaWithDistance != null
        ? _formatDistance(_selectedAreaWithDistance!.distanceMeters)
        : '';

    return InkWell(
      onTap: () => _openAreaPicker(areas),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        color: AppTheme.primary.withValues(alpha: 0.1),
        child: Row(
          children: [
            const Icon(Icons.location_on, color: AppTheme.primary),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  if (distText.isNotEmpty)
                    Text(
                      distText,
                      style: AppTheme.bodySmall
                          .copyWith(color: AppTheme.textSecondary),
                    ),
                ],
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, color: AppTheme.primary),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard(String vehicleType, IconData icon) {
    final pricing = _selectedArea!.pricing[vehicleType];
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
                Icon(icon, size: 32, color: AppTheme.primary),
                const SizedBox(width: 12),
                Text(_formatVehicleType(vehicleType), style: AppTheme.resolvedHeading3(context)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  Formatters.currency(pricing.monthly / 100),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primary,
                  ),
                ),
                Text(
                  '/month',
                  style:
                      AppTheme.bodySmall.copyWith(color: AppTheme.textSecondary),
                ),
                const Spacer(),
                Text(
                  '${Formatters.currency(pricing.dailyRate / 100)}/day',
                  style:
                      AppTheme.bodySmall.copyWith(color: AppTheme.textSecondary),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildFeature('Daily professional car wash'),
            _buildFeature('Doorstep service'),
            _buildFeature('Experienced staff'),
            _buildFeature('Photo proof of cleaning'),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _onSubscribeTap(vehicleType, pricing),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Subscribe Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeature(String text) {
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

  Widget _buildErrorWidget(String error) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Icon(Icons.error_outline, size: 48, color: AppTheme.error),
          const SizedBox(height: 16),
          Text(
            'Error loading areas: $error',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => ref.invalidate(sortedAreasByDistanceProvider),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildNoAreasWidget() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.location_off, size: 64, color: AppTheme.textSecondary),
          const SizedBox(height: 16),
          Text(
            'Service Not Available',
            style: AppTheme.resolvedHeading3(context),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Sorry, ZepWash is not available in your area yet. We\'re expanding soon!',
            style: AppTheme.resolvedBodyMedium(context).copyWith(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppTheme.darkTextSecondary
                  : AppTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Text(
            'Contact us at ${AppConstants.supportPhone}',
            style: AppTheme.resolvedBodySmall(context),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Modal bottom sheet with search + pagination
// ---------------------------------------------------------------------------

class _AreaPickerSheet extends StatefulWidget {
  final List<AreaWithDistance> areas;
  final ValueChanged<AreaWithDistance> onAreaSelected;

  const _AreaPickerSheet({
    required this.areas,
    required this.onAreaSelected,
  });

  @override
  State<_AreaPickerSheet> createState() => _AreaPickerSheetState();
}

class _AreaPickerSheetState extends State<_AreaPickerSheet> {
  static const int _pageSize = 5;

  String _query = '';
  int _visibleCount = _pageSize;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<AreaWithDistance> get _filtered {
    if (_query.isEmpty) return widget.areas;
    final q = _query.toLowerCase();
    return widget.areas
        .where((a) => a.area.name.toLowerCase().contains(q))
        .toList();
  }

  String _formatDistance(double? meters) {
    if (meters == null) return '';
    if (meters < 1000) return '${meters.round()} m away';
    return '${(meters / 1000).toStringAsFixed(1)} km away';
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;
    final visible = filtered.take(_visibleCount).toList();
    final hasMore = filtered.length > _visibleCount;

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select Your Service Location',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                controller: _searchController,
                onChanged: (v) => setState(() {
                  _query = v;
                  _visibleCount = _pageSize;
                }),
                decoration: InputDecoration(
                  hintText: 'Search areas...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _query.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _query = '';
                              _visibleCount = _pageSize;
                            });
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
            ),

            const Divider(height: 1),

            // List
            Expanded(
              child: ListView.separated(
                controller: scrollController,
                itemCount: visible.length + (hasMore ? 1 : 0),
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  if (index == visible.length) {
                    // Load More button
                    return TextButton(
                      onPressed: () =>
                          setState(() => _visibleCount += _pageSize),
                      child: const Text('Load More'),
                    );
                  }

                  final awd = visible[index];
                  final distText = _formatDistance(awd.distanceMeters);

                  return ListTile(
                    leading: const Icon(Icons.location_on_outlined,
                        color: AppTheme.primary),
                    title: Text(awd.area.name),
                    subtitle: distText.isNotEmpty ? Text(distText) : null,
                    onTap: () {
                      Navigator.of(context).pop();
                      widget.onAreaSelected(awd);
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
