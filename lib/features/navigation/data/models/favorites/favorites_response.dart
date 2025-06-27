class FavoritesResponse {
  final bool status;
  final String message;

  FavoritesResponse({required this.status, required this.message});

  factory FavoritesResponse.fromJson(Map<String, dynamic> json) {
    return FavoritesResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
    );
  }
}
