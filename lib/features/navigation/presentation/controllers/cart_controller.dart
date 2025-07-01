// cart_controller.dart
import 'package:digital_shop/core/services/api_service.dart';
import 'package:digital_shop/features/navigation/data/datasources/navegation_remote_datasource.dart';
import 'package:digital_shop/features/navigation/data/models/cart/cart_request.dart';
import 'package:digital_shop/features/navigation/data/models/cart/get_cart_response.dart';
import 'package:digital_shop/features/navigation/data/models/order/order_request.dart';
import 'package:digital_shop/features/navigation/data/models/payment/payment_request.dart';
import 'package:digital_shop/features/navigation/data/models/payment/payment_response.dart';
import 'package:digital_shop/features/navigation/domain/repositories/implement/navegation_repository.dart';
import 'package:digital_shop/features/navigation/domain/useCases/navegation_usecase.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController {
  final NavegationUseCase _cartUseCase;
  final SharedPreferences _prefs;

  CartController(this._cartUseCase, this._prefs);

  static Future<CartController> create() async {
    final prefs = await SharedPreferences.getInstance();
    final apiService = ApiService();
    final remoteDatasource = NavegationRemoteDatasource(apiService);
    final repository = NavegationRepositoryImpl(remoteDatasource);
    final useCase = NavegationUseCase(repository);

    return CartController(useCase, prefs);
  }

  Future<List<GetCartItem>> getCartItems() async {
    final userId = _prefs.getInt('userId');
    if (userId == null) {
      throw Exception('Usuario no autenticado');
    }
    return await _cartUseCase.executeGetCartItems(userId);
  }

  Future<void> addToCart({
    required int productId,
    required BuildContext context,
    int quantity = 1,
  }) async {
    final userId = _prefs.getInt('userId');
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debes iniciar sesión primero')),
      );
      return;
    }

    try {
      final request = CartRequest(
        userId: userId,
        productId: productId,
        quantity: quantity,
      );

      final response = await _cartUseCase.executeAddToCart(request);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.message)),
      );
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al agregar al carrito: $e')),
      );
    }
  }

  Future<void> removeFromCart(int productId, BuildContext context) async {
    final userId = _prefs.getInt('userId');
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debes iniciar sesión primero')),
      );
      return;
    }

    try {
      final response = await _cartUseCase.executeRemoveFromCart(
        CartRequest(userId: userId, productId: productId),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.message)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al eliminar del carrito: $e')),
      );
    }
  }

  Future<void> updateQuantity(
      int productId, int newQuantity, BuildContext context) async {
    final userId = _prefs.getInt('userId');
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debes iniciar sesión primero')),
      );
      return;
    }

    try {
      final response = await _cartUseCase.executeUpdateQuantity(
        CartRequest(
          userId: userId,
          productId: productId,
          quantity: newQuantity,
        ),
      );

      if (!response.status) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar cantidad: $e')),
      );
    }
  }

  Future<Map<String, dynamic>> createOrder({
    String? shippingAddress,
    String? notes,
    required BuildContext context,
  }) async {
    final OrderRequest request = OrderRequest(
      shippingAddress: shippingAddress,
      notes: notes,
    );

    try {
      final userId = _prefs.getInt('userId');
      if (userId == null) {
        throw Exception('Usuario no autenticado');
      }
      final response = await _cartUseCase.executeCreateOrder(request);
      return response;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al crear la orden: $e')),
      );
      rethrow;
    }
  }

  Future<PaymentResponse> createPayment({
    required int orderId,
    required BuildContext context,
  }) async {
    try {
      // Usamos URLs de prueba para desarrollo
      const successUrl = 'https://success.digitalshop';
      const failureUrl = 'https://fail.digitalshop';

      final response = await _cartUseCase.executeCreatePayment(
        PaymentRequest(
          method: 'mercado_pago',
          orderId: orderId,
          successUrl: successUrl,
          failureUrl: failureUrl,
        ),
      );

      return response;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al crear el pago: $e')),
      );
      rethrow;
    }
  }

  // Future<void> launchPaymentUrl(String url, BuildContext context) async {
  //   try {
  //     final uri = Uri.parse(Uri.encodeFull(url));

  //     // Intentamos primero abrir con navegador externo
  //     bool launched = await launchUrl(
  //       uri,
  //       mode: LaunchMode.externalApplication,
  //     );

  //     if (!launched) {
  //       // Si no se puede abrir con navegador, intentamos WebView integrado
  //       launched = await launchUrl(
  //         uri,
  //         mode: LaunchMode.inAppWebView,
  //       );
  //     }

  //     if (!launched) {
  //       throw 'No se pudo abrir la URL ni con navegador externo ni con WebView';
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error al abrir el pago: $e')),
  //     );
  //   }
  // }
}
