import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user.dart';

part 'payment.freezed.dart';
part 'payment.g.dart';

@freezed
class Payment with _$Payment {
  const factory Payment({
    required String id,
    required String customerId,
    required String razorpayPaymentId,
    required int amount,
    @Default('success') String status, // 'success' | 'failed' | 'refunded'
    String? razorpaySubscriptionId,
    String? razorpayOrderId,
    @TimestampConverter() required DateTime createdAt,
  }) = _Payment;

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);

  factory Payment.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    data['id'] = doc.id;
    return Payment.fromJson(data);
  }
}
