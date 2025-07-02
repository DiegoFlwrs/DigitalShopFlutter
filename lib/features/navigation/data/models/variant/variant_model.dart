class Variant {
  final int id;
  final int productId;
  final String color;
  final String size;
  final int stock;
  final double price;
  final String? sku;
  final String imageUrl;

  Variant({
    required this.id,
    required this.productId,
    required this.color,
    required this.size,
    required this.stock,
    required this.price,
    this.sku,
    required this.imageUrl,
  });

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      id: json['id'],
      productId: json['productId'],
      color: json['color'],
      size: json['size'],
      stock: json['stock'],
      price: (json['price'] as num).toDouble(),
      sku: json['sku'],
      imageUrl: json['imageUrl'],
    );
  }
}