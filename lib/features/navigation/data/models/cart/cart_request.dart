class CartRequest {
  final int userId;
  final int productId;
  final int quantity;

  CartRequest({
    required this.userId,
    required this.productId,
    this.quantity = 1,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'productId': productId,
        'quantity': quantity,
      };
}