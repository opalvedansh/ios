// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomerImpl _$$CustomerImplFromJson(Map<String, dynamic> json) =>
    _$CustomerImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      label: json['label'] as String?,
      address: json['address'] as String? ?? '',
      geopoint: json['geopoint'] == null
          ? const GeoPoint(0, 0)
          : const GeoPointConverter().fromJson(json['geopoint'] as GeoPoint),
      vehicleType: json['vehicleType'] as String? ?? 'sedan',
      plateCode: json['plateCode'] as String? ?? '',
      vehicleModel: json['vehicleModel'] as String? ?? '',
      assignedStaffId: json['assignedStaffId'] as String?,
      activeSubscriptionId: json['activeSubscriptionId'] as String?,
      subscriptionStatus: json['subscriptionStatus'] as String? ?? 'inactive',
      currentPlanId: json['currentPlanId'] as String?,
      currentAreaId: json['currentAreaId'] as String?,
      currentPeriodEnd: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['currentPeriodEnd'], const TimestampConverter().fromJson),
      createdAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['createdAt'], const TimestampConverter().fromJson),
    );

Map<String, dynamic> _$$CustomerImplToJson(_$CustomerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'label': instance.label,
      'address': instance.address,
      'geopoint': const GeoPointConverter().toJson(instance.geopoint),
      'vehicleType': instance.vehicleType,
      'plateCode': instance.plateCode,
      'vehicleModel': instance.vehicleModel,
      'assignedStaffId': instance.assignedStaffId,
      'activeSubscriptionId': instance.activeSubscriptionId,
      'subscriptionStatus': instance.subscriptionStatus,
      'currentPlanId': instance.currentPlanId,
      'currentAreaId': instance.currentAreaId,
      'currentPeriodEnd': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.currentPeriodEnd, const TimestampConverter().toJson),
      'createdAt': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.createdAt, const TimestampConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
