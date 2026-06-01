import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user.dart';

part 'staff.freezed.dart';
part 'staff.g.dart';

@freezed
class Staff with _$Staff {
  const factory Staff({
    required String uid,
    @Default('Unknown Staff') String name,
    @Default('') String phone,
    @Default('') String assignedAreaId,
    @Default(true) bool isAvailable,
    @Default(false) bool isVerified,
    @Default(0) int dailyRate, // Per car per day
    @Default(0) int assignedCustomersCount,
    @Default(0.0) double currentMonthSalary,
    @Default(0) int currentMonthCleanings,
    @TimestampConverter() required DateTime createdAt,
    String? fcmToken,
  }) = _Staff;

  factory Staff.fromJson(Map<String, dynamic> json) => _$StaffFromJson(json);

  factory Staff.fromFirestore(DocumentSnapshot doc) {
    final data = (doc.data() as Map<String, dynamic>?) ?? {};
    data['uid'] = doc.id;
    if (data['createdAt'] == null) {
      data['createdAt'] = Timestamp.now();
    }
    return Staff.fromJson(data);
  }
}
