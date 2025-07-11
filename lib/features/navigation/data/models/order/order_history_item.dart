class OrderHistoryItem {
  final int id;
  final String title;
  final String status;
  final String date;

  OrderHistoryItem({
    required this.id,
    required this.title,
    required this.status,
    required this.date,
  });

  factory OrderHistoryItem.fromJson(Map<String, dynamic> json) {
    return OrderHistoryItem(
      id: json['id'],
      title: json['title'],
      status: json['status'],
      date: json['date'],
    );
  }
}
