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
  final int id;
  final int cartId;
  final int productVariantId;
  final int quantity;
  final int? productId; 

  CartItem({
    required this.id,
    required this.cartId,
    required this.productVariantId,
    required this.quantity,
    this.productId,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      cartId: json['cartId'],
      productVariantId: json['productVariantId'],
      quantity: json['quantity'],
      productId: json['productId'],
    );
  }
}
