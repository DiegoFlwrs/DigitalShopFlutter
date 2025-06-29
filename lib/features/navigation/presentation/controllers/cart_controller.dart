// cart_controller.dart
import 'package:digital_shop/core/services/api_service.dart';
import 'package:digital_shop/features/navigation/data/datasources/navegation_remote_datasource.dart';
import 'package:digital_shop/features/navigation/data/models/cart/cart_request.dart';
import 'package:digital_shop/features/navigation/data/models/cart/cart_response.dart';
import 'package:digital_shop/features/navigation/data/models/cart/get_cart_response.dart';
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

  Future<void> updateQuantity(int productId, int newQuantity, BuildContext context) async {
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
}