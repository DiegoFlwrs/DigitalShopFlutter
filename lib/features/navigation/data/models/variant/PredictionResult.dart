class PredictionResponse {
  final int orderCount;
  final double totalSpent;
  final double averageSpend;

  PredictionResponse({
    required this.orderCount,
    required this.totalSpent,
    required this.averageSpend,
  });

  factory PredictionResponse.fromJson(Map<String, dynamic> json) {
    return PredictionResponse(
      orderCount: json['orderCount'],
      totalSpent: (json['totalSpent'] as num).toDouble(),
      averageSpend: (json['averageSpend'] as num).toDouble(),
    );
  }
}
