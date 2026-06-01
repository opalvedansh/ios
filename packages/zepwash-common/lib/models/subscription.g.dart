// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubscriptionImpl _$$SubscriptionImplFromJson(Map<String, dynamic> json) =>
    _$SubscriptionImpl(
      id: json['id'] as String,
      customerId: json['customerId'] as String,
      planId: json['planId'] as String,
      areaId: json['areaId'] as String,
      vehicleType: json['vehicleType'] as String,
      razorpaySubscriptionId: json['razorpaySubscriptionId'] as String?,
      razorpayCustomerId: json['razorpayCustomerId'] as String?,
      status: json['status'] as String? ?? 'active',
      startDate:
          const TimestampConverter().fromJson(json['startDate'] as Timestamp),
      currentPeriodStart: const TimestampConverter()
          .fromJson(json['currentPeriodStart'] as Timestamp),
      currentPeriodEnd: const TimestampConverter()
          .fromJson(json['currentPeriodEnd'] as Timestamp),
      cancelledAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['cancelledAt'], const TimestampConverter().fromJson),
      pausedAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['pausedAt'], const TimestampConverter().fromJson),
      currentCycleDays: (json['currentCycleDays'] as num?)?.toInt() ?? 0,
      currentCycleCleaned: (json['currentCycleCleaned'] as num?)?.toInt() ?? 0,
      currentCycleMissed: (json['currentCycleMissed'] as num?)?.toInt() ?? 0,
      totalCycles: (json['totalCycles'] as num?)?.toInt() ?? 0,
      totalDaysCleaned: (json['totalDaysCleaned'] as num?)?.toInt() ?? 0,
      totalDaysMissed: (json['totalDaysMissed'] as num?)?.toInt() ?? 0,
      previousPlanId: json['previousPlanId'] as String?,
      lastPlanChangeDate: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['lastPlanChangeDate'], const TimestampConverter().fromJson),
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
      updatedAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['updatedAt'], const TimestampConverter().fromJson),
    );

Map<String, dynamic> _$$SubscriptionImplToJson(_$SubscriptionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'planId': instance.planId,
      'areaId': instance.areaId,
      'vehicleType': instance.vehicleType,
      'razorpaySubscriptionId': instance.razorpaySubscriptionId,
      'razorpayCustomerId': instance.razorpayCustomerId,
      'status': instance.status,
      'startDate': const TimestampConverter().toJson(instance.startDate),
      'currentPeriodStart':
          const TimestampConverter().toJson(instance.currentPeriodStart),
      'currentPeriodEnd':
          const TimestampConverter().toJson(instance.currentPeriodEnd),
      'cancelledAt': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.cancelledAt, const TimestampConverter().toJson),
      'pausedAt': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.pausedAt, const TimestampConverter().toJson),
      'currentCycleDays': instance.currentCycleDays,
      'currentCycleCleaned': instance.currentCycleCleaned,
      'currentCycleMissed': instance.currentCycleMissed,
      'totalCycles': instance.totalCycles,
      'totalDaysCleaned': instance.totalDaysCleaned,
      'totalDaysMissed': instance.totalDaysMissed,
      'previousPlanId': instance.previousPlanId,
      'lastPlanChangeDate': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.lastPlanChangeDate, const TimestampConverter().toJson),
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.updatedAt, const TimestampConverter().toJson),
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

_$SubscriptionHistoryImpl _$$SubscriptionHistoryImplFromJson(
        Map<String, dynamic> json) =>
    _$SubscriptionHistoryImpl(
      id: json['id'] as String,
      subscriptionId: json['subscriptionId'] as String,
      customerId: json['customerId'] as String,
      eventType: json['eventType'] as String,
      changes: json['changes'] as Map<String, dynamic>,
      reason: json['reason'] as String?,
      initiatedBy: json['initiatedBy'] as String?,
      timestamp:
          const TimestampConverter().fromJson(json['timestamp'] as Timestamp),
    );

Map<String, dynamic> _$$SubscriptionHistoryImplToJson(
        _$SubscriptionHistoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subscriptionId': instance.subscriptionId,
      'customerId': instance.customerId,
      'eventType': instance.eventType,
      'changes': instance.changes,
      'reason': instance.reason,
      'initiatedBy': instance.initiatedBy,
      'timestamp': const TimestampConverter().toJson(instance.timestamp),
    };
