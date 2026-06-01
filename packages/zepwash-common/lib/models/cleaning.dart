import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user.dart';

part 'cleaning.freezed.dart';
part 'cleaning.g.dart';

@freezed
class Cleaning with _$Cleaning {
  const factory Cleaning({
    required String id,
    required String customerId,
    required String staffId,
    required String date, // Format: yyyy-MM-dd
    @Default('pending') String status, // 'completed' | 'missed' | 'pending'
    String? photoUrl,
    @TimestampConverter() DateTime? completedAt,
    @GeoPointConverter() GeoPoint? staffLocation,
    @TimestampConverter() required DateTime createdAt,
  }) = _Cleaning;

  factory Cleaning.fromJson(Map<String, dynamic> json) =>
      _$CleaningFromJson(json);

  factory Cleaning.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    data['id'] = doc.id;
    return Cleaning.fromJson(data);
  }
}
