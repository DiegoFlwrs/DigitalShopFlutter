class PaymentResponse {
  final String id;
  final String status;
  final String? paymentUrl;
  final String? qrCode;
  final String? transactionId;

  PaymentResponse({
    required this.id,
    required this.status,
    this.paymentUrl,
    this.qrCode,
    this.transactionId,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      id: json['id'],
      status: json['status'],
      paymentUrl: json['paymentUrl'],
      qrCode: json['qrCode'],
      transactionId: json['transactionId'],
    );
  }
}