// ignore: deprecated_member_use
import 'dart:js' as js;
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
  void Function(RazorpayPaymentSuccess)? _onSuccess;
  void Function(RazorpayPaymentFailure)? _onError;
  void Function()? _onWalletSelection;

  void initialize({
    required void Function(RazorpayPaymentSuccess response) onSuccess,
    required void Function(RazorpayPaymentFailure response) onError,
    required void Function() onWalletSelection,
  }) {
    _onSuccess = onSuccess;
    _onError = onError;
    _onWalletSelection = onWalletSelection;
  }

  Future<void> openSubscriptionCheckout({
    required String razorpaySubscriptionId,
    required String userName,
    required String userPhone,
  }) async {
    final capturedOnSuccess = _onSuccess;
    final capturedOnError = _onError;

    // Success: Razorpay calls handler(response) with payment details
    final successHandler =
        // ignore: deprecated_member_use
        js.allowInterop((js.JsObject response) {
      final paymentId = response['razorpay_payment_id'] as String?;
      capturedOnSuccess?.call(RazorpayPaymentSuccess(paymentId: paymentId));
    });

    // Failure: fires on the 'payment.failed' event
    final failureHandler =
        // ignore: deprecated_member_use
        js.allowInterop((js.JsObject response) {
      final error = response['error'];
      final message =
          error is js.JsObject ? error['description'] as String? : null;
      capturedOnError?.call(RazorpayPaymentFailure(message: message));
    });

    // ignore: deprecated_member_use
    final options = js.JsObject.jsify(<String, dynamic>{
      'key': AppConstants.razorpayKeyId,
      'subscription_id': razorpaySubscriptionId,
      'name': 'ZepWash',
      'description': 'Monthly Car Wash Subscription',
      'prefill': <String, dynamic>{
        'contact': userPhone,
        'name': userName,
      },
      'handler': successHandler,
    });

    // ignore: deprecated_member_use
    final rzp = js.JsObject(js.context['Razorpay'] as js.JsFunction, [options]);
    rzp.callMethod('on', ['payment.failed', failureHandler]);
    rzp.callMethod('open');
  }

  void dispose() {}
}
