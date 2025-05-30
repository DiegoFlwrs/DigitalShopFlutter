class SendCodeResponse {
  final String message;

  SendCodeResponse({required this.message});

  factory SendCodeResponse.fromJson(Map<String, dynamic> json) {
    return SendCodeResponse(
      message: json['message'] ?? '',
    );
  }
}
