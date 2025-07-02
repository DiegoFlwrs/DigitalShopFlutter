class VariantDetails {
  final int id;
  final String color;
  final String size;
  final int stock;
  final double price;
  final String? imageUrl;

  VariantDetails({
    required this.id,
    required this.color,
    required this.size,
    required this.stock,
    required this.price,
    this.imageUrl,
  });

  factory VariantDetails.fromJson(Map<String, dynamic> json) {
    return VariantDetails(
      id: json['id'],
      color: json['color'],
      size: json['size'],
      stock: json['stock'],
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'],
    );
  }
}