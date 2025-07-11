class PaymentHistoryItem {
  final int id;
  final String title;
  final String amount;
  final String date;
  final String status;

  PaymentHistoryItem({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.status,
  });

  factory PaymentHistoryItem.fromJson(Map<String, dynamic> json) {
    return PaymentHistoryItem(
      id: json['id'],
      title: json['title'],
      amount: json['amount'],
      date: json['date'],
      status: json['status'],
    );
  }
}
