class RegisterResponse {
  final int id;
  final String name;
  final String email;
  final String password;
  final bool active;
  final List<UserRole> roles;

  RegisterResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.active,
    required this.roles,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    var rolesList = (json['roles'] as List)
        .map((roleJson) => UserRole.fromJson(roleJson))
        .toList();

    return RegisterResponse(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      active: json['active'],
      roles: rolesList,
    );
  }
}

class UserRole {
  final int userId;
  final int roleId;
  final Role role;

  UserRole({
    required this.userId,
    required this.roleId,
    required this.role,
  });

  factory UserRole.fromJson(Map<String, dynamic> json) {
    return UserRole(
      userId: json['userId'],
      roleId: json['roleId'],
      role: Role.fromJson(json['role']),
    );
  }
}

class Role {
  final int id;
  final String name;

  Role({
    required this.id,
    required this.name,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      name: json['name'],
    );
  }
}
