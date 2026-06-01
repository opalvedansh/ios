import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../constants/app_constants.dart';

class RazorpayPaymentSuccess {
  const RazorpayPaymentSuccess({this.paymentId});

  final String? paymentId;
}

class RazorpayPaymentFailure {
  const RazorpayPaymentFailure({this.message});

  final String? message;
}

class RazorpayService {
  late Razorpay _razorpay;

  void initialize({
    required void Function(RazorpayPaymentSuccess response) onSuccess,
    required void Function(RazorpayPaymentFailure response) onError,
    required void Function() onWalletSelection,
  }) {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (response) {
      final success = response as PaymentSuccessResponse;
      onSuccess(RazorpayPaymentSuccess(paymentId: success.paymentId));
    });
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (response) {
      final failure = response as PaymentFailureResponse;
      onError(RazorpayPaymentFailure(message: failure.message));
    });
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, (_) {
      onWalletSelection();
    });
  }

  Future<void> openSubscriptionCheckout({
    required String razorpaySubscriptionId,
    required String userName,
    required String userPhone,
  }) async {
    final options = {
      'key': AppConstants.razorpayKeyId,
      'subscription_id': razorpaySubscriptionId,
      'name': 'ZepWash',
      'description': 'Monthly Car Wash Subscription',
      'prefill': {
        'contact': userPhone,
        'name': userName,
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      throw Exception('Failed to open Razorpay: $e');
    }
  }

  void dispose() {
    _razorpay.clear();
  }
}
