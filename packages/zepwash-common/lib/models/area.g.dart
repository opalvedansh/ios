// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AreaImpl _$$AreaImplFromJson(Map<String, dynamic> json) => _$AreaImpl(
      id: json['id'] as String,
      name: json['name'] as String? ?? 'Unknown Area',
      city: json['city'] as String? ?? 'Unknown City',
      center: const GeoPointConverter().fromJson(json['center'] as GeoPoint),
      radiusKm: (json['radiusKm'] as num?)?.toDouble() ?? 0.0,
      isActive: json['isActive'] as bool? ?? true,
      pricing: (json['pricing'] as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, VehiclePricing.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
      supervisorIds: (json['supervisorIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$AreaImplToJson(_$AreaImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'city': instance.city,
      'center': const GeoPointConverter().toJson(instance.center),
      'radiusKm': instance.radiusKm,
      'isActive': instance.isActive,
      'pricing': instance.pricing,
      'supervisorIds': instance.supervisorIds,
    };

_$VehiclePricingImpl _$$VehiclePricingImplFromJson(Map<String, dynamic> json) =>
    _$VehiclePricingImpl(
      monthly: (json['monthly'] as num?)?.toInt() ?? 0,
      dailyRate: (json['dailyRate'] as num?)?.toInt() ?? 0,
      planId: json['planId'] as String? ?? '',
    );

Map<String, dynamic> _$$VehiclePricingImplToJson(
        _$VehiclePricingImpl instance) =>
    <String, dynamic>{
      'monthly': instance.monthly,
      'dailyRate': instance.dailyRate,
      'planId': instance.planId,
    };
