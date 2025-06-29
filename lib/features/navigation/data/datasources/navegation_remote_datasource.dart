import 'dart:convert';

import 'package:digital_shop/features/navigation/data/models/cart/cart_request.dart';
import 'package:digital_shop/features/navigation/data/models/cart/cart_response.dart';
import 'package:digital_shop/features/navigation/data/models/cart/get_cart_response.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/CategoryStatisticResponse.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/favorites_isFavorite_response.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/favorites_list_request.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/favorites_list_response.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/favorites_request.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/favorites_response.dart';

import '../../../../core/services/api_service.dart';


class NavegationRemoteDatasource {
  final ApiService _apiService;

  NavegationRemoteDatasource(this._apiService);

  Future<FavoritesResponse> addFavorite(FavoriteRequest request) async {
    final json = await _apiService.post('/favorites/add', request.toJson());
    return FavoritesResponse.fromJson(json);
  }

  Future<FavoritesResponse> removeFavorite(FavoriteRequest request) async {
    final json = await _apiService.post('/favorites/remove', request.toJson());
    return FavoritesResponse.fromJson(json);
  }

  Future<FavoritesIsFavoriteResponse> isFavorite(FavoriteRequest request) async {
    final json = await _apiService.post('/favorites/check', request.toJson());
    return FavoritesIsFavoriteResponse.fromJson(json);
  }

  Future<List<GetFavoritesListResponse>> getFavorites(FavoriteListRequest request) async {
  final jsonList = await _apiService.post('/favorites/list', request.toJson());
  return (jsonList as List)
      .map((json) => GetFavoritesListResponse.fromJson(json))
      .toList();
}

Future<List<CategoryStatisticResponse>> getFavoritesStatisticsByCategory() async {
  final Map<String, dynamic> jsonMap = await _apiService.get('/statistics/favorites-by-category');
  return jsonMap.entries
      .map((entry) => CategoryStatisticResponse(
            categoryName: entry.key,
            count: entry.value as int,
          ))
      .toList();
}

Future<CartResponse> addToCart(CartRequest request) async {
  final json = await _apiService.post('/cart/add', request.toJson());
  
  if (json == null || json is! Map<String, dynamic>) {
    throw Exception('Respuesta inválida del servidor al agregar al carrito');
  }
  return CartResponse.fromJson(json);
}

  Future<CartResponse> removeFromCart(CartRequest request) async {
    final json = await _apiService.delete(
      '/cart/remove/${request.userId}/${request.productId}',
    );
    return CartResponse.fromJson(json);
  }

  Future<List<GetCartItem>> getCartItems(int userId) async {
    final jsonList = await _apiService.get('/cart/items/$userId');
    return (jsonList as List).map((json) => GetCartItem.fromJson(json)).toList();
  }

  Future<CartResponse> updateQuantity(CartRequest request) async {
    final json = await _apiService.post('/cart/update', request.toJson());
    return CartResponse.fromJson(json);
  }



}
