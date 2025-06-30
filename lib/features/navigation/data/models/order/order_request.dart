class OrderRequest {
  final String? shippingAddress;
  final String? notes;

  OrderRequest({
    this.shippingAddress,
    this.notes,
  });

  Map<String, dynamic> toJson() => {
        if (shippingAddress != null) 'shippingAddress': shippingAddress,
        if (notes != null) 'notes': notes,
      };
}