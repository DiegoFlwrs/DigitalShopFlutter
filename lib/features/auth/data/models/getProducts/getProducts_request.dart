class GetProductRequest {
  final String consulta;

  GetProductRequest({required this.consulta});

  Map<String, dynamic> toJson() => {
        'consulta': consulta,
      };
}
