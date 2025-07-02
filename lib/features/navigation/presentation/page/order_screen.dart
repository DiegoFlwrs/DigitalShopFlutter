import 'package:digital_shop/features/navigation/data/models/cart/get_cart_response.dart';
import 'package:digital_shop/features/navigation/presentation/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:digital_shop/core/constants/app_colors.dart';

class OrderScreen extends StatefulWidget {
  final double total;
  final List<GetCartItem> cartItems;

  const OrderScreen({
    super.key,
    required this.total,
    required this.cartItems,
  });

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Color _parseColor(String colorName) {
    final colorMap = {
      'rojo': Colors.red,
      'azul': Colors.blue,
      'verde': Colors.green,
      'negro': Colors.black,
      'blanco': Colors.white,
    };
    return colorMap[colorName.toLowerCase()] ?? Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Resumen de productos
              const Text(
                'Productos:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = widget.cartItems[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            // Imagen del producto
                            Image.network(
                              item.imageUrl,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image, size: 60),
                            ),
                            const SizedBox(width: 12),
                            // Detalles del producto
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 4),
                                  Text('Cantidad: ${item.quantity}'),
                                  if (item.color != null) ...[
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Text('Color: '),
                                        Container(
                                          width: 16,
                                          height: 16,
                                          decoration: BoxDecoration(
                                            color: _parseColor(item.color!),
                                            shape: BoxShape.circle,
                                            border:
                                                Border.all(color: Colors.grey),
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(item.color!),
                                      ],
                                    ),
                                  ],
                                  if (item.size != null) ...[
                                    const SizedBox(height: 4),
                                    Text('Talla: ${item.size}'),
                                  ],
                                ],
                              ),
                            ),
                            // Precio
                            Text(
                              '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Dirección de envío
              const SizedBox(height: 16),
              const Text(
                'Dirección de envío:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  hintText: 'Ingresa tu dirección completa',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu dirección';
                  }
                  return null;
                },
              ),

              // Notas adicionales
              const SizedBox(height: 16),
              const Text(
                'Notas adicionales:',
                style: TextStyle(fontSize: 16),
              ),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  hintText: 'Ej: Piso, departamento, referencias, etc.',
                ),
                maxLines: 3,
              ),

              // Total y botón de pago
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${widget.total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: _submitOrder,
                  child: const Text(
                    'Pagar ahora',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitOrder() {
    if (_formKey.currentState!.validate()) {
      // Pasar los datos de vuelta a CartScreen para procesar el pago
      Navigator.pop(context, {
        'shippingAddress': _addressController.text,
        'notes': _notesController.text,
      });
    }
  }
}
