import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:zepwash_common/zepwash_common.dart' hide RazorpayService;
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/providers/firestore_provider.dart';
import '../../../../core/services/razorpay_service.dart';
import '../../../../features/home/providers/customer_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/gradient_scaffold.dart';
import '../../../../shared/widgets/platform_alert.dart';
import '../../../../shared/widgets/platform_button.dart';
import '../../../../shared/widgets/platform_scaffold.dart';
import '../../../../shared/widgets/platform_text_field.dart';

/// Screen to collect vehicle details and address before payment
class VehicleDetailsScreen extends ConsumerStatefulWidget {
  final String areaId;
  final String vehicleType;
  final String planId;
  final int monthlyPrice;

  const VehicleDetailsScreen({
    super.key,
    required this.areaId,
    required this.vehicleType,
    required this.planId,
    required this.monthlyPrice,
  });

  @override
  ConsumerState<VehicleDetailsScreen> createState() =>
      _VehicleDetailsScreenState();
}

class _VehicleDetailsScreenState extends ConsumerState<VehicleDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _vehicleTypeController = TextEditingController();
  final _vehicleModelController = TextEditingController();
  final _plateCodeController = TextEditingController();
  final _addressController = TextEditingController();

  late RazorpayService _razorpayService;
  bool _nameExists = false;
  bool _isLoading = false;
  bool _waitingForActivation = false;
  String? _razorpaySubscriptionId;
  String? _firestoreSubscriptionId;
  String? _newCustomerId; // auto-generated customer doc ID returned from initiateSubscription
  StreamSubscription<DocumentSnapshot>? _customerDocSubscription;
  Timer? _activationTimeout;

  @override
  void initState() {
    super.initState();

    final user = ref.read(authStateProvider).value;
    _phoneController.text = user?.phoneNumber ?? '';
    _vehicleTypeController.text = _formatVehicleType(widget.vehicleType);

    _prefillName();

    _razorpayService = RazorpayService();
    _razorpayService.initialize(
      onSuccess: _handlePaymentSuccess,
      onError: _handlePaymentError,
      onWalletSelection: () {},
    );
  }

  @override
  void dispose() {
    _razorpayService.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _vehicleTypeController.dispose();
    _vehicleModelController.dispose();
    _plateCodeController.dispose();
    _addressController.dispose();
    _customerDocSubscription?.cancel();
    _activationTimeout?.cancel();
    super.dispose();
  }

  Future<void> _prefillName() async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;
    final doc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    final name = doc.data()?['name'] as String?;
    if (mounted) {
      setState(() {
        if (name != null && name.isNotEmpty) {
          _nameController.text = name;
          _nameExists = true;
        } else {
          _nameExists = false;
        }
      });
    }
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

  Future<void> _onProceedToPayment() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      Position? currentPosition;

      if (!kIsWeb) {
        // Location is only available on mobile; web passes 0,0.
        final locationService = LocationService();
        try {
          currentPosition = await locationService.getCurrentPosition();
        } on LocationException catch (e) {
          setState(() => _isLoading = false);
          if (mounted) {
            final isPermanentlyDenied = e.message.contains('permanently denied');
            final isServiceDisabled = e.message.contains('disabled');

            final result = await showPlatformAlert(
              context: context,
              title: isServiceDisabled ? 'Location Services Disabled' : 'Location Required',
              content: '${e.message}. We need your location to confirm service availability at your address. Would you like to try again?',
              confirmText: (isPermanentlyDenied || isServiceDisabled) ? 'Settings' : 'Try Again',
              cancelText: 'Cancel',
            );

            if (result == true) {
              if (isPermanentlyDenied) {
                await Geolocator.openAppSettings();
              } else if (isServiceDisabled) {
                await Geolocator.openLocationSettings();
              } else {
                _onProceedToPayment(); // Recursive retry
              }
            }
            return;
          }
        }
      }

      final callable = FirebaseFunctions.instanceFor(region: 'asia-south1')
          .httpsCallable('initiateSubscription');
      final result = await callable.call({
        'planId': widget.planId,
        'areaId': widget.areaId,
        'vehicleType': widget.vehicleType,
        'vehicleModel': _vehicleModelController.text.trim(),
        'plateCode': _plateCodeController.text.trim().toUpperCase(),
        'address': _addressController.text.trim(),
        'latitude': currentPosition?.latitude ?? 0.0,
        'longitude': currentPosition?.longitude ?? 0.0,
      });

      _razorpaySubscriptionId =
          result.data['razorpaySubscriptionId'] as String;
      _firestoreSubscriptionId = result.data['subscriptionId'] as String;
      _newCustomerId = result.data['customerId'] as String?;

      await _razorpayService.openSubscriptionCheckout(
        razorpaySubscriptionId: _razorpaySubscriptionId!,
        userName: _nameController.text.trim(),
        userPhone: _phoneController.text.trim(),
      );
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        showPlatformError(context, 'Failed to initiate payment: $e');
      }
    }
  }

  Future<void> _handlePaymentSuccess(RazorpayPaymentSuccess response) async {
    setState(() => _isLoading = true);

    try {
      final userId = ref.read(currentUserIdProvider);
      if (userId == null) throw Exception('User not authenticated');

      // Update user profile name/phone (idempotent)
      final firestoreService = ref.read(firestoreServiceProvider);
      final user = User(
        uid: userId,
        role: 'customer',
        name: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        createdAt: DateTime.now(),
      );
      await firestoreService.setDocument('users', userId, user.toJson());

      setState(() {
        _isLoading = false;
        _waitingForActivation = true;
      });

      _activationTimeout = Timer(const Duration(seconds: 45), () {
        if (!mounted) return;
        setState(() => _waitingForActivation = false);
        showPlatformError(
          context,
          'Subscription activation is taking longer than expected. '
          'Your payment was received — please reopen the app in a few minutes.',
        );
      });

      // Watch the specific new customer doc (auto-generated ID from initiateSubscription)
      // Fallback to userId only if _newCustomerId is null (shouldn't happen)
      final watchId = _newCustomerId ?? userId;
      
      _customerDocSubscription = FirebaseFirestore.instance
          .collection('customers')
          .doc(watchId)
          .snapshots()
          .listen((doc) {
        if (doc.exists && doc.data()?['subscriptionStatus'] == 'active') {
          _activationTimeout?.cancel();
          _customerDocSubscription?.cancel();
          if (mounted) {
            // Set this new vehicle as the selected profile
            ref.read(selectedCustomerIdProvider.notifier).state = watchId;
            context.go('/home');
          }
        }
      }, onError: (e) {
        debugPrint('Error watching customer doc: $e');
      });

      // Alternative: also watch the subscription document as a backup
      if (_firestoreSubscriptionId != null) {
        FirebaseFirestore.instance
            .collection('subscriptions')
            .doc(_firestoreSubscriptionId)
            .snapshots()
            .listen((doc) {
          if (doc.exists && doc.data()?['status'] == 'active') {
            final data = doc.data();
            final cid = data?['customerId'] as String?;
            if (cid != null && mounted && _waitingForActivation) {
              _activationTimeout?.cancel();
              _customerDocSubscription?.cancel();
              ref.read(selectedCustomerIdProvider.notifier).state = cid;
              context.go('/home');
            }
          }
        });
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        showPlatformError(
          context,
          'Payment successful but profile setup failed. Please contact support. Error: $e',
        );
      }
    }
  }

  Future<void> _handlePaymentError(RazorpayPaymentFailure response) async {
    setState(() => _isLoading = false);

    if (_firestoreSubscriptionId != null) {
      try {
        await FirebaseFirestore.instance
            .collection('subscriptions')
            .doc(_firestoreSubscriptionId!)
            .delete();
      } catch (_) {}
      _firestoreSubscriptionId = null;
      _razorpaySubscriptionId = null;
    }

    if (mounted) {
      showPlatformError(
        context,
        'Payment failed: ${response.message ?? "Unknown error"}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (_waitingForActivation) {
      return PlatformScaffold(
        title: 'Activating Subscription',
        showBackButton: false,
        body: GradientScaffold(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: isDark ? AppTheme.darkPrimary : AppTheme.primary,
                ),
                const SizedBox(height: 24),
                Text(
                  'Activating your subscription...',
                  style: AppTheme.resolvedHeading3(context),
                ),
                const SizedBox(height: 8),
                Text(
                  'Please wait while we confirm your payment.',
                  style: AppTheme.resolvedBodySmall(context),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    final accentColor = isDark ? AppTheme.darkPrimary : AppTheme.primary;
    final secondaryTextColor =
        isDark ? AppTheme.darkTextSecondary : AppTheme.textSecondary;

    return PlatformScaffold(
      title: 'Complete Your Details',
      body: GradientScaffold(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              // ── Selected plan summary ──────────────────────────────────
              _buildPlanSummaryCard(context, isDark, accentColor),
              const SizedBox(height: 24),

              // ── Section: Personal Details ──────────────────────────────
              _buildSectionHeader(context, 'Personal Details'),
              const SizedBox(height: 16),
              PlatformTextField(
                controller: _nameController,
                label: 'Full Name',
                enabled: !_nameExists,
                validator: _nameExists
                    ? null
                    : (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
              ),
              const SizedBox(height: 16),
              PlatformTextField(
                controller: _phoneController,
                label: 'Phone Number',
                enabled: false,
              ),
              const SizedBox(height: 24),

              // ── Section: Vehicle Details ───────────────────────────────
              _buildSectionHeader(context, 'Vehicle Details'),
              const SizedBox(height: 16),
              PlatformTextField(
                controller: _vehicleTypeController,
                label: 'Vehicle Type',
                enabled: false,
              ),
              const SizedBox(height: 16),
              PlatformTextField(
                controller: _vehicleModelController,
                label: 'Vehicle Model',
                hint: 'Honda City, Maruti Swift, etc.',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter vehicle model';
                  }
                  if (value.length < 3) {
                    return 'Vehicle model must be at least 3 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              PlatformTextField(
                controller: _plateCodeController,
                label: 'License Plate (Last 6 characters)',
                hint: 'AB1234',
                maxLength: 6,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')),
                  UpperCaseTextFormatter(),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter plate code';
                  }
                  return Validators.plateCode(value);
                },
              ),
              const SizedBox(height: 24),

              // ── Section: Service Address ───────────────────────────────
              _buildSectionHeader(context, 'Service Address'),
              const SizedBox(height: 4),
              Text(
                'Where should we wash your car?',
                style: AppTheme.resolvedBodySmall(context).copyWith(
                  color: secondaryTextColor,
                ),
              ),
              const SizedBox(height: 16),
              PlatformTextField(
                controller: _addressController,
                label: 'Full Address',
                hint: 'House no., Street, Landmark, City, State, Pincode',
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full address';
                  }
                  if (value.length < 10) {
                    return 'Please enter a complete address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              PlatformButton(
                text: 'Proceed to Payment',
                onPressed: _onProceedToPayment,
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanSummaryCard(
    BuildContext context,
    bool isDark,
    Color accentColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: isDark ? 0.15 : 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: accentColor.withValues(alpha: isDark ? 0.35 : 0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.directions_car, color: accentColor, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selected Plan',
                  style: AppTheme.resolvedBodySmall(context),
                ),
                const SizedBox(height: 4),
                Text(
                  '${_formatVehicleType(widget.vehicleType)} · '
                  '${Formatters.currency(widget.monthlyPrice / 100)}/month',
                  style: AppTheme.resolvedHeading3(context).copyWith(
                    color: accentColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        Container(
          width: 3,
          height: 20,
          decoration: BoxDecoration(
            color: isDark ? AppTheme.darkPrimary : AppTheme.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(title, style: AppTheme.resolvedHeading3(context)),
      ],
    );
  }
}

/// Text formatter to convert input to uppercase
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
