import 'package:digital_shop/features/navigation/data/models/cart/cart_request.dart';
import 'package:digital_shop/features/navigation/data/models/cart/cart_response.dart';
import 'package:digital_shop/features/navigation/data/models/cart/get_cart_response.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/CategoryStatisticResponse.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/favorites_isFavorite_response.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/favorites_list_request.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/favorites_list_response.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/favorites_request.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/favorites_response.dart';
import 'package:digital_shop/features/navigation/data/models/order/order_request.dart';
import 'package:digital_shop/features/navigation/data/models/payment/payment_request.dart';
import 'package:digital_shop/features/navigation/data/models/payment/payment_response.dart';
import 'package:digital_shop/features/navigation/data/models/variant/VariantDetails_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<FavoritesIsFavoriteResponse> isFavorite(
      FavoriteRequest request) async {
    final json = await _apiService.post('/favorites/check', request.toJson());
    return FavoritesIsFavoriteResponse.fromJson(json);
  }

  Future<List<GetFavoritesListResponse>> getFavorites(
      FavoriteListRequest request) async {
    final jsonList =
        await _apiService.post('/favorites/list', request.toJson());
    return (jsonList as List)
        .map((json) => GetFavoritesListResponse.fromJson(json))
        .toList();
  }

  Future<List<CategoryStatisticResponse>>
      getFavoritesStatisticsByCategory() async {
    final Map<String, dynamic> jsonMap =
        await _apiService.get('/statistics/favorites-by-category');
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
    final json = await _apiService.get('/cart/items/$userId');
    final cartResponse = GetCartResponse.fromJson(json);
    return cartResponse.items;
  }

  Future<CartResponse> updateQuantity(CartRequest request) async {
    final json = await _apiService.post('/cart/update', request.toJson());
    return CartResponse.fromJson(json);
  }

  Future<Map<String, dynamic>> createOrder(OrderRequest request) async {
    final data = {
      if (request.shippingAddress != null)
        'shippingAddress': request.shippingAddress,
      if (request.notes != null) 'notes': request.notes,
    };
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("tokenAccess");
    final json =
        await _apiService.postToken('/orders', data, 'Bearer $accessToken');
    return json as Map<String, dynamic>;
  }

  Future<PaymentResponse> createPayment(PaymentRequest request) async {
    final localStorage = await SharedPreferences.getInstance();
    final accessToken = localStorage.getString("tokenAccess");
    final json = await _apiService.postToken(
        '/payments', request.toJson(), 'Bearer $accessToken');
    return PaymentResponse.fromJson(json);
  }

  Future<int> getUserId() async {
    final localStorage = await SharedPreferences.getInstance();
    final userId = localStorage.getInt('userId');
    if (userId == null) {
      throw Exception('User not authenticated');
    }
    return userId;
  }

  Future<List<Variant>> getProductVariants(int productId) async {
    final json = await _apiService.get('/variants/$productId');
    return (json as List).map((v) => Variant.fromJson(v)).toList();
  }

  Future<List<String>> getAvailableColors(int productId) async {
    final json = await _apiService.get('/variants/$productId/colors');
    return (json as List).cast<String>();
  }

  Future<List<String>> getAvailableSizes(int productId) async {
    final json = await _apiService.get('/variants/$productId/sizes');
    return (json as List).cast<String>();
  }

  Future<List<String>> getSizesForColor(int productId, String color) async {
    final json = await _apiService.get(
      '/variants/$productId/sizes-for-color',
      queryParams: {'color': color},
    );
    return (json as List).cast<String>();
  }

  Future<List<String>> getColorsForSize(int productId, String size) async {
    final json = await _apiService.get(
      '/variants/$productId/colors-for-size',
      queryParams: {'size': size},
    );
    return (json as List).cast<String>();
  }

  Future<VariantDetails> getVariantDetails(
    int productId,
    String color,
    String size,
  ) async {
    final json = await _apiService.get(
      '/variants/$productId/variant-details',
      queryParams: {'color': color, 'size': size},
    );
    return VariantDetails.fromJson(json);
  }

  Future<Map<String, dynamic>> getFirstVariantForColor(int productId, String color) async {
  final response = await _apiService.get(
    '/variants/$productId/first-variant-for-color?color=$color'
  );
  return response;
}

}
