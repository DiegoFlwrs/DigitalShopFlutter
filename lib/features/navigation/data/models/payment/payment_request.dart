class PaymentRequest {
  final String method;
  final int orderId;
  final String successUrl;
  final String failureUrl;

  PaymentRequest({
    required this.method,
    required this.orderId,
    required this.successUrl,
    required this.failureUrl,
  });

  Map<String, dynamic> toJson() => {
        'method': method,
        'orderId': orderId,
        'successUrl': successUrl,
        'failureUrl': failureUrl,
      };
}