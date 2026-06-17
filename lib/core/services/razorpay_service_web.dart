// Web implementation of RazorpayService using dart:js_interop (Dart ≥ 3.3)
// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:js_interop';
import '../constants/app_constants.dart';

// ── Minimal JS interop bindings ──────────────────────────────────────────────

@JS('Razorpay')
@staticInterop
class _RazorpayJs {
  external factory _RazorpayJs(JSObject options);
}

extension _RazorpayJsExt on _RazorpayJs {
  external void on(JSString event, JSFunction handler);
  external void open();
}

// ── Public Dart types ─────────────────────────────────────────────────────────

class RazorpayPaymentSuccess {
  const RazorpayPaymentSuccess({this.paymentId});
  final String? paymentId;
}

class RazorpayPaymentFailure {
  const RazorpayPaymentFailure({this.message});
  final String? message;
}

// ── Service ───────────────────────────────────────────────────────────────────

class RazorpayService {
  void Function(RazorpayPaymentSuccess)? _onSuccess;
  void Function(RazorpayPaymentFailure)? _onError;

  void initialize({
    required void Function(RazorpayPaymentSuccess response) onSuccess,
    required void Function(RazorpayPaymentFailure response) onError,
    required void Function() onWalletSelection,
  }) {
    _onSuccess = onSuccess;
    _onError = onError;
  }

  Future<void> openSubscriptionCheckout({
    required String razorpaySubscriptionId,
    required String userName,
    required String userPhone,
  }) async {
    final capturedOnSuccess = _onSuccess;
    final capturedOnError = _onError;

    // Build the options map and convert to a JS object via jsify
    final optionsMap = <String, dynamic>{
      'key': AppConstants.razorpayKeyId,
      'subscription_id': razorpaySubscriptionId,
      'name': 'ZepWash',
      'description': 'Monthly Car Wash Subscription',
      'prefill': <String, dynamic>{
        'contact': userPhone,
        'name': userName,
      },
      'handler': (JSObject response) {
        // response.razorpay_payment_id
        final map = (response.dartify() as Map?)?.cast<String, dynamic>();
        final paymentId = map?['razorpay_payment_id'] as String?;
        capturedOnSuccess?.call(RazorpayPaymentSuccess(paymentId: paymentId));
      }.toJS,
    };

    final jsOptions = optionsMap.jsify()! as JSObject;
    final rzp = _RazorpayJs(jsOptions);

    rzp.on(
      'payment.failed'.toJS,
      (JSObject response) {
        final map = (response.dartify() as Map?)?.cast<String, dynamic>();
        final error = map?['error'] as Map<dynamic, dynamic>?;
        final message = error?['description'] as String?;
        capturedOnError?.call(RazorpayPaymentFailure(message: message));
      }.toJS,
    );

    rzp.open();
  }

  void dispose() {}
}
