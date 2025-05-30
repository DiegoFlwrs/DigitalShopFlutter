class VerifyCodeResponse {
  final bool valid;

  VerifyCodeResponse({required this.valid});

  factory VerifyCodeResponse.fromJson(Map<String, dynamic> json) {
    return VerifyCodeResponse(
      valid: json['valid'],
    );
  }
}
