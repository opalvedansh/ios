import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user.dart';

part 'complaint.freezed.dart';
part 'complaint.g.dart';

@freezed
class Complaint with _$Complaint {
  const factory Complaint({
    required String id,
    required String customerId,
    required String
        category, // 'missed_cleaning' | 'quality' | 'behaviour' | 'other'
    required String description,
    String? imageUrl,
    @Default('open') String status, // 'open' | 'in_progress' | 'resolved'
    String? resolution,
    @TimestampConverter() DateTime? resolvedAt,
    @TimestampConverter() required DateTime createdAt,
  }) = _Complaint;

  factory Complaint.fromJson(Map<String, dynamic> json) =>
      _$ComplaintFromJson(json);

  factory Complaint.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    data['id'] = doc.id;
    return Complaint.fromJson(data);
  }
}
