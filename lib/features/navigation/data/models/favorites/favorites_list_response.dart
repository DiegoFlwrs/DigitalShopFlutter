class GetFavoritesListResponse {
  final int id;
  final String name;
  final String description;
  final double basePrice;
  final String brand;
  final int categoryId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Variant> variants;
  final Category category;
  bool isFavorite;

  GetFavoritesListResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.basePrice,
    required this.brand,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.variants,
    required this.category,
    this.isFavorite = false,
  });

  factory GetFavoritesListResponse.fromJson(Map<String, dynamic> json) {
    return GetFavoritesListResponse(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      basePrice: (json['basePrice'] as num).toDouble(),
      brand: json['brand'],
      categoryId: json['categoryId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      variants: (json['variants'] != null)
    ? (json['variants'] as List)
        .map((v) => Variant.fromJson(v))
        .toList()
    : [],
      category: Category.fromJson(json['category']),
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'basePrice': basePrice,
      'brand': brand,
      'categoryId': categoryId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'variants': variants.map((v) => v.toJson()).toList(),
      'category': category.toJson(),
      'isFavorite': isFavorite,
    };
  }
}
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
    required this.sku,
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'color': color,
      'size': size,
      'stock': stock,
      'price': price,
      'sku': sku,
      'imageUrl': imageUrl,
    };
  }
}

class Category {
  final int id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
