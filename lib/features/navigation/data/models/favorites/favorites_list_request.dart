class FavoriteListRequest {
  final int userId;

  FavoriteListRequest({
    required this.userId,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
      };
}
