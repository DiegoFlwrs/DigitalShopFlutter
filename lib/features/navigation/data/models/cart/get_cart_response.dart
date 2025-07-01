class GetCartResponse {
  final bool status;
  final String message;
  final GetCartItem? item;

  GetCartResponse({
    required this.status,
    required this.message,
    this.item,
  });

  factory GetCartResponse.fromJson(Map<String, dynamic> json) {
    return GetCartResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      item: json['item'] != null ? GetCartItem.fromJson(json['item']) : null,
    );
  }
}

class GetCartItem {
  final int id;
  final int productId;
  final String name;
  final double price;
  final String imageUrl;
  final String category;
  int quantity;

  GetCartItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.quantity,
  });

  factory GetCartItem.fromJson(Map<String, dynamic> json) {
    return GetCartItem(
      id: json['id'],
      productId: json['productId'],
      name: json['name'] ?? 'Producto sin nombre',
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] ?? '',
      category: json['category'] ?? 'Sin categoría',
      quantity: json['quantity'] ?? 1,
    );
  }
}