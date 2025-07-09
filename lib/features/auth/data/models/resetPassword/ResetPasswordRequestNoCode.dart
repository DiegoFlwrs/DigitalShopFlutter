class ResetPasswordNoCodeRequest {
  final String email;
  final String newPassword;

  ResetPasswordNoCodeRequest({
    required this.email,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'newPassword': newPassword,
      };
}
