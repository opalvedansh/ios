// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeaveImpl _$$LeaveImplFromJson(Map<String, dynamic> json) => _$LeaveImpl(
      id: json['id'] as String,
      staffId: json['staffId'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      reason: json['reason'] as String,
      status: json['status'] as String? ?? 'pending',
      adminNote: json['adminNote'] as String?,
      approvedAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['approvedAt'], const TimestampConverter().fromJson),
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
    );

Map<String, dynamic> _$$LeaveImplToJson(_$LeaveImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'staffId': instance.staffId,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'reason': instance.reason,
      'status': instance.status,
      'adminNote': instance.adminNote,
      'approvedAt': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.approvedAt, const TimestampConverter().toJson),
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
