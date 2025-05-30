import 'dart:convert';

import 'package:digital_shop/features/auth/data/models/getProducts/getProducts_request.dart';
import 'package:digital_shop/features/auth/data/models/getProducts/getProducts_response.dart';
import 'package:digital_shop/features/auth/domain/useCases/login_usecase.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetProductsController {
  final consultaController = TextEditingController();
  final LoginUseCase loginUseCase;

  GetProductsController(this.loginUseCase);

  Future<void> getProducts(BuildContext context) async {
    final request = GetProductRequest(
      consulta: consultaController.text,
      // consulta: "madnaome todo lo que tengas",
    );

    try {
      final List<GetProductResponse> products = await loginUseCase.executeGetProducts(request);

    //   final prefs = await SharedPreferences.getInstance();
    //   final List<String> productsJsonList = products.map((product) => jsonEncode(product.toJson())).toList();

    // if (productsJsonList != null) {
    //   final List<GetProductResponse> products = productsJsonList
    //     .map((jsonStr) => GetProductResponse.fromJson(jsonDecode(jsonStr)))
    //     .toList();
    // }
    for (var product in products) {
      print('Producto encontrado: ${product.name}');
    }

    Navigator.pushNamed(context, "/home");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Productos encontrados")),
    );


      // Navigator.pushReplacementNamed(context, '/search');

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }
}
