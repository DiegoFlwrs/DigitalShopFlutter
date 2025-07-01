// cart_screen.dart
import 'package:digital_shop/core/constants/app_colors.dart';
import 'package:digital_shop/features/navigation/data/models/cart/get_cart_response.dart';
import 'package:digital_shop/features/navigation/presentation/controllers/cart_controller.dart';
import 'package:digital_shop/features/navigation/presentation/page/web/Payment_web.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late CartController _cartController;
  List<GetCartItem> _cartItems = [];
  bool _isLoading = true;
  double _total = 0.0;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  Future<void> _initializeController() async {
    try {
      final controller = await CartController.create();
      setState(() {
        _cartController = controller;
      });
      await _loadCartItems();
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al inicializar: $e')),
      );
    }
  }

  Future<void> _loadCartItems() async {
    try {
      final items = await _cartController.getCartItems();
      final total = _calculateTotal(items);

      setState(() {
        _cartItems = items;
        _total = total;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar el carrito: $e')),
      );
    }
  }

  double _calculateTotal(List<GetCartItem> items) {
    return items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  Future<void> _refreshCart() async {
    setState(() => _isLoading = true);
    await _loadCartItems();
  }

  Future<void> _proceedToPayment(BuildContext context) async {
    try {
      // Mostrar diálogo de confirmación
      final shouldProceed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Confirmar compra'),
          content: const Text('¿Estás seguro que deseas proceder con el pago?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Confirmar'),
            ),
          ],
        ),
      );

      if (shouldProceed != true) return;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      final order = await _cartController.createOrder(
        shippingAddress: 'BArrio 2',
        notes: "A domicilio",
        context: context,
      );

      final payment = await _cartController.createPayment(
        orderId: order['id'],
        context: context,
      );

      // Cerrar el diálogo de carga
      Navigator.pop(context);

      // final url ="https://www.mercadopago.com.pe/checkout/v1/redirect?pref_id=2522288611-d97e8947-3d4a-4f27-8b03-3b1014555653";
      // print(""+ payment.paymentUrl!);

      // 3. Abrir la URL de pago de MercadoPago
      if (payment.paymentUrl != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PaymentWebView(paymentUrl: payment.paymentUrl!),
          ),
        );
      } else {
        throw 'No se recibió URL de pago';
      }
    } catch (e) {
      // Cerrar el diálogo de carga si hay error
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error en el proceso de pago: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Mi Carrito'),
      //   backgroundColor: AppColors.primary,
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.refresh),
      //       onPressed: _refreshCart,
      //     ),
      //   ],
      // ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _cartItems.isEmpty
              ? const Center(
                  child: Text('Tu carrito está vacío'),
                )
              : Column(
                  children: [
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: _refreshCart,
                        child: ListView.builder(
                          itemCount: _cartItems.length,
                          itemBuilder: (context, index) {
                            final item = _cartItems[index];
                            return _buildCartItem(item);
                          },
                        ),
                      ),
                    ),
                    _buildTotalSection(),
                  ],
                ),
    );
  }

  Widget _buildCartItem(GetCartItem item) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image, size: 80),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '\$${item.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    item.category,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    await _cartController.removeFromCart(
                        item.productId, context);
                    await _refreshCart();
                  },
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () async {
                        if (item.quantity > 1) {
                          await _cartController.updateQuantity(
                            item.productId,
                            item.quantity - 1,
                            context,
                          );
                          await _refreshCart();
                        }
                      },
                    ),
                    Text(item.quantity.toString()),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () async {
                        await _cartController.updateQuantity(
                          item.productId,
                          item.quantity + 1,
                          context,
                        );
                        await _refreshCart();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$${_total.toStringAsFixed(2)}',
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
              onPressed: () => _proceedToPayment(context),
              child: const Text(
                'Proceder al pago',
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
    );
  }
}
