class GetCartResponse {
  final bool status;
  final String message;
  final List<GetCartItem> items;

  GetCartResponse({
    required this.status,
    required this.message,
    required this.items,
  });

  factory GetCartResponse.fromJson(Map<String, dynamic> json) {
    return GetCartResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      items:
          (json['items'] as List).map((e) => GetCartItem.fromJson(e)).toList(),
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

  final String? color; // Nuevo
  final String? size; // Nuevo

  GetCartItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.quantity,
    this.color,
    this.size,
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
      color: json['color'], // Nuevo
      size: json['size'],
    );
  }
}
