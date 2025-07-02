// variants_controller.dart
import 'package:digital_shop/features/navigation/data/models/variant/VariantDetails_model.dart';
import 'package:digital_shop/features/navigation/domain/useCases/navegation_usecase.dart';
import 'package:flutter/material.dart';

class VariantsController {
  final NavegationUseCase _useCase;

  VariantsController(this._useCase);

  Future<List<String>> getAvailableColors(int productId) async {
    try {
      return await _useCase.executeGetAvailableColors(productId);
    } catch (e) {
      debugPrint('Error getting colors: $e');
      return [];
    }
  }

  Future<List<String>> getAvailableSizes(int productId) async {
    try {
      return await _useCase.executeGetAvailableSizes(productId);
    } catch (e) {
      debugPrint('Error getting sizes: $e');
      return [];
    }
  }

  Future<List<String>> getSizesForColor(int productId, String color) async {
    try {
      return await _useCase.executeGetSizesForColor(productId, color);
    } catch (e) {
      debugPrint('Error getting sizes for color: $e');
      return [];
    }
  }

  Future<List<String>> getColorsForSize(int productId, String size) async {
    try {
      return await _useCase.executeGetColorsForSize(productId, size);
    } catch (e) {
      debugPrint('Error getting colors for size: $e');
      return [];
    }
  }

  Future<VariantDetails?> getVariantDetails(
    int productId, 
    String color, 
    String size,
    BuildContext context,
  ) async {
    try {
      return await _useCase.executeGetVariantDetails(productId, color, size);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al obtener detalles de la variante: $e')),
      );
      return null;
    }
  }

  Future<FirstVariantResponse?> getFirstVariantForColor(
  int productId,
  String color,
  BuildContext context,
) async {
  try {
    final response = await _useCase.executeGetFirstVariantForColor(productId, color);
    
    if (response == null) {
      return null;
    }

    return FirstVariantResponse(
      imageUrl: response['imageUrl'],
      price: response['price'].toDouble(),
      availableSizes: List<String>.from(response['availableSizes']),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error al obtener variante por color: $e')),
    );
    return null;
  }
}

}

class FirstVariantResponse {
  final String imageUrl;
  final double price;
  final List<String> availableSizes;

  FirstVariantResponse({
    required this.imageUrl,
    required this.price,
    required this.availableSizes,
  });
}