class LoginResponse {
  final String token;
  final String message;
  final int userId;

  LoginResponse({required this.token, required this.message, required this.userId});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        token: json['access_token'],
        userId: json['userId'],
        message: "200",
      );
}