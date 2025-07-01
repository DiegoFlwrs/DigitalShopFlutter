class CartResponse {
  final bool status;
  final String message;
  final CartItem? item;

  CartResponse({
    required this.status,
    required this.message,
    this.item,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      item: json['item'] != null ? CartItem.fromJson(json['item']) : null,
    );
  }
}

class CartItem {
  // final int id;
  final int productId;
  final int quantity;

  CartItem({
    // required this.id,
    required this.productId,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      // id: json['id'] | 0,
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }
}