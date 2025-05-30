// login_response.dart
class LoginResponse {
  final String token;
  final String message;

  LoginResponse({required this.token, required this.message});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        token: json['access_token'],
        message: "200",
      );
}