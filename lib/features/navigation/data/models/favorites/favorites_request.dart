class FavoriteRequest {
  final int userId;
  final int productId;

  FavoriteRequest({
    required this.userId,
    required this.productId,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'productId': productId,
      };
}
