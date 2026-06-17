import 'package:flutter/material.dart';
import '../../../../shared/widgets/platform_scaffold.dart';
import '../../../home/presentation/widgets/plan_selection_view.dart';

/// Screen for adding a second/third vehicle to an existing account.
/// Reuses PlanSelectionView — on plan selection it pushes to VehicleDetailsScreen.
class AddVehicleScreen extends StatelessWidget {
  const AddVehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlatformScaffold(
      title: 'Add Vehicle',
      body: PlanSelectionView(),
    );
  }
}
