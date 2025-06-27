class FavoritesIsFavoriteResponse {
  final bool isFavorite;

  FavoritesIsFavoriteResponse({required this.isFavorite});

  factory FavoritesIsFavoriteResponse.fromJson(Map<String, dynamic> json) {
    return FavoritesIsFavoriteResponse(
      isFavorite: json['isFavorite'] ?? false,
    );
  }
}
