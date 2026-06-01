import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user.dart';

part 'leave.freezed.dart';
part 'leave.g.dart';

@freezed
class Leave with _$Leave {
  const factory Leave({
    required String id,
    required String staffId,
    required String startDate, // Format: yyyy-MM-dd
    required String endDate, // Format: yyyy-MM-dd
    required String reason,
    @Default('pending') String status, // 'pending' | 'approved' | 'rejected'
    String? adminNote,
    @TimestampConverter() DateTime? approvedAt,
    @TimestampConverter() required DateTime createdAt,
  }) = _Leave;

  factory Leave.fromJson(Map<String, dynamic> json) => _$LeaveFromJson(json);

  factory Leave.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    data['id'] = doc.id;
    // Handle null or missing createdAt field (common during server propagation)
    if (data['createdAt'] == null) {
      data['createdAt'] = Timestamp.now();
    }
    return Leave.fromJson(data);
  }
}
