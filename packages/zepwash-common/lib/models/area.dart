import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user.dart';

part 'area.freezed.dart';
part 'area.g.dart';

@freezed
class Area with _$Area {
  const factory Area({
    required String id,
    @Default('Unknown Area') String name,
    @Default('Unknown City') String city,
    @GeoPointConverter() required GeoPoint center,
    @Default(0.0) double radiusKm,
    @Default(true) bool isActive,
    @Default({}) Map<String, VehiclePricing> pricing,
    @Default([]) List<String> supervisorIds,
  }) = _Area;

  factory Area.fromJson(Map<String, dynamic> json) => _$AreaFromJson(json);

  factory Area.fromFirestore(DocumentSnapshot doc) {
    final data = (doc.data() as Map<String, dynamic>?) ?? {};
    data['id'] = doc.id;
    return Area.fromJson(data);
  }
}

@freezed
class VehiclePricing with _$VehiclePricing {
  const factory VehiclePricing({
    @Default(0) int monthly,
    @Default(0) int dailyRate,
    @Default('') String planId, // Razorpay plan ID
  }) = _VehiclePricing;

  factory VehiclePricing.fromJson(Map<String, dynamic> json) =>
      _$VehiclePricingFromJson(json);
}
