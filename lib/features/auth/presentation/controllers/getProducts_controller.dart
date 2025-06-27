import 'dart:convert';
import 'package:digital_shop/features/auth/data/models/getProducts/getProducts_request.dart';
import 'package:digital_shop/features/auth/data/models/getProducts/getProducts_response.dart';
import 'package:digital_shop/features/auth/domain/useCases/login_usecase.dart';
import 'package:digital_shop/features/navigation/presentation/widgets/ProductListScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetProductsController {
  final consultaController = TextEditingController();
  final LoginUseCase loginUseCase;

  GetProductsController(this.loginUseCase);

  Future<void> getProducts(BuildContext context) async {
    final request = GetProductRequest(
      consulta: consultaController.text,
    );

    try {
      final List<GetProductResponse> products =
          await loginUseCase.executeGetProducts(request);

      final prefs = await SharedPreferences.getInstance();
      final List<String> productsJsonList =
          products.map((product) => jsonEncode(product.toJson())).toList();

      await prefs.setStringList('products', productsJsonList); // ✅ Aquí guardas

      Navigator.pushNamed(context, "/home"); 

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Productos encontrados")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  Future<void> getProductsSearch(BuildContext context) async {
  final request = GetProductRequest(consulta: consultaController.text);
  try {
    final List<GetProductResponse> products = await loginUseCase.executeGetProducts(request);
    final prefs = await SharedPreferences.getInstance();
    final productsJsonList = products.map((p) => jsonEncode(p.toJson())).toList();
    await prefs.setStringList('products', productsJsonList);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Productos encontrados")),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: ${e.toString()}')),
    );
  }
}
}
