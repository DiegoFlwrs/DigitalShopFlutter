class RegisterRequest {
  final String name;
  final String email;
  final String password;
  final List<int>? roles;
  final bool? active;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
    this.roles,
    this.active,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'roles': [1],
        'active': true,
      };
}
