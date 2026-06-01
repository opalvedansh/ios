// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cleaning.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CleaningImpl _$$CleaningImplFromJson(Map<String, dynamic> json) =>
    _$CleaningImpl(
      id: json['id'] as String,
      customerId: json['customerId'] as String,
      staffId: json['staffId'] as String,
      date: json['date'] as String,
      status: json['status'] as String? ?? 'pending',
      photoUrl: json['photoUrl'] as String?,
      completedAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['completedAt'], const TimestampConverter().fromJson),
      staffLocation: _$JsonConverterFromJson<GeoPoint, GeoPoint>(
          json['staffLocation'], const GeoPointConverter().fromJson),
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
    );

Map<String, dynamic> _$$CleaningImplToJson(_$CleaningImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'staffId': instance.staffId,
      'date': instance.date,
      'status': instance.status,
      'photoUrl': instance.photoUrl,
      'completedAt': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.completedAt, const TimestampConverter().toJson),
      'staffLocation': _$JsonConverterToJson<GeoPoint, GeoPoint>(
          instance.staffLocation, const GeoPointConverter().toJson),
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
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
