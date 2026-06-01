class RazorpayPaymentSuccess {
  const RazorpayPaymentSuccess({this.paymentId});

  final String? paymentId;
}

class RazorpayPaymentFailure {
  const RazorpayPaymentFailure({this.message});

  final String? message;
}

class RazorpayService {
  void initialize({
    required void Function(RazorpayPaymentSuccess response) onSuccess,
    required void Function(RazorpayPaymentFailure response) onError,
    required void Function() onWalletSelection,
  }) {}

  Future<void> openSubscriptionCheckout({
    required String razorpaySubscriptionId,
    required String userName,
    required String userPhone,
  }) async {
    throw UnsupportedError(
      'Razorpay checkout is not available on this platform.',
    );
  }

  void dispose() {}
}
