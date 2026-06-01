// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentImpl _$$PaymentImplFromJson(Map<String, dynamic> json) =>
    _$PaymentImpl(
      id: json['id'] as String,
      customerId: json['customerId'] as String,
      razorpayPaymentId: json['razorpayPaymentId'] as String,
      amount: (json['amount'] as num).toInt(),
      status: json['status'] as String? ?? 'success',
      razorpaySubscriptionId: json['razorpaySubscriptionId'] as String?,
      razorpayOrderId: json['razorpayOrderId'] as String?,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
    );

Map<String, dynamic> _$$PaymentImplToJson(_$PaymentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'razorpayPaymentId': instance.razorpayPaymentId,
      'amount': instance.amount,
      'status': instance.status,
      'razorpaySubscriptionId': instance.razorpaySubscriptionId,
      'razorpayOrderId': instance.razorpayOrderId,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
