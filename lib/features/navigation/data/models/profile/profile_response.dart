class ProfiResponse {
  final String id;
  final String name;
  final String email;

  ProfiResponse({
    required this.id,
    required this.name,
    required this.email,
  });

  factory ProfiResponse.fromJson(Map<String, dynamic> json) {
    return ProfiResponse(
      id: json['id'].toString(),
      name: json['name'],
      email: json['email'],
    );
  }
}
