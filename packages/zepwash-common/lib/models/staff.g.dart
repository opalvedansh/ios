// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StaffImpl _$$StaffImplFromJson(Map<String, dynamic> json) => _$StaffImpl(
      uid: json['uid'] as String,
      name: json['name'] as String? ?? 'Unknown Staff',
      phone: json['phone'] as String? ?? '',
      assignedAreaId: json['assignedAreaId'] as String? ?? '',
      isAvailable: json['isAvailable'] as bool? ?? true,
      isVerified: json['isVerified'] as bool? ?? false,
      dailyRate: (json['dailyRate'] as num?)?.toInt() ?? 0,
      assignedCustomersCount:
          (json['assignedCustomersCount'] as num?)?.toInt() ?? 0,
      currentMonthSalary:
          (json['currentMonthSalary'] as num?)?.toDouble() ?? 0.0,
      currentMonthCleanings:
          (json['currentMonthCleanings'] as num?)?.toInt() ?? 0,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
      fcmToken: json['fcmToken'] as String?,
    );

Map<String, dynamic> _$$StaffImplToJson(_$StaffImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'phone': instance.phone,
      'assignedAreaId': instance.assignedAreaId,
      'isAvailable': instance.isAvailable,
      'isVerified': instance.isVerified,
      'dailyRate': instance.dailyRate,
      'assignedCustomersCount': instance.assignedCustomersCount,
      'currentMonthSalary': instance.currentMonthSalary,
      'currentMonthCleanings': instance.currentMonthCleanings,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'fcmToken': instance.fcmToken,
    };
