import 'package:digital_shop/features/navigation/data/models/cart/cart_request.dart';
import 'package:digital_shop/features/navigation/data/models/cart/cart_response.dart';
import 'package:digital_shop/features/navigation/data/models/cart/get_cart_response.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/CategoryStatisticResponse.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/favorites_isFavorite_response.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/favorites_list_request.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/favorites_list_response.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/favorites_request.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/favorites_response.dart';
import 'package:digital_shop/features/navigation/data/models/order/order_history_item.dart';
import 'package:digital_shop/features/navigation/data/models/order/order_request.dart';
import 'package:digital_shop/features/navigation/data/models/payment/paymentHistoryItem.dart';
import 'package:digital_shop/features/navigation/data/models/payment/payment_request.dart';
import 'package:digital_shop/features/navigation/data/models/payment/payment_response.dart';
import 'package:digital_shop/features/navigation/data/models/profile/profile_response.dart';
import 'package:digital_shop/features/navigation/data/models/variant/PredictionResult.dart';
import 'package:digital_shop/features/navigation/data/models/variant/VariantDetails_model.dart';
import 'package:digital_shop/features/navigation/domain/repositories/implement/navegation_repository.dart';

class NavegationUseCase {
  final NavegationRepositoryImpl repository;

  NavegationUseCase(this.repository);

  Future<FavoritesResponse> executeAddFavorite(FavoriteRequest request) async {
    return await repository.addFavorite(request);
  }

  Future<FavoritesResponse> executeRemoveFavorite(
      FavoriteRequest request) async {
    return await repository.removeFavorite(request);
  }

  Future<FavoritesIsFavoriteResponse> executeIsFavorite(
      FavoriteRequest request) async {
    return await repository.isFavorite(request);
  }

  Future<List<GetFavoritesListResponse>> executeGetFavorites(
      FavoriteListRequest request) async {
    return await repository.getFavorites(request);
  }

  Future<List<CategoryStatisticResponse>>
      executeGetFavoritesStatisticsByCategory(int userId) async {
    return await repository.getFavoritesStatisticsByCategory(userId);
  }

  Future<CartResponse> executeAddToCart(CartRequest request) async {
    return await repository.addToCart(request);
  }

  Future<CartResponse> executeRemoveFromCart(CartRequest request) async {
    return await repository.removeFromCart(request);
  }

  Future<List<GetCartItem>> executeGetCartItems(int userId) async {
    return await repository.getCartItems(userId);
  }

  Future<CartResponse> executeUpdateQuantity(CartRequest request) async {
    return await repository.updateQuantity(request);
  }

  Future<Map<String, dynamic>> executeCreateOrder(OrderRequest request) async {
    return await repository.createOrder(request);
  }

  Future<PaymentResponse> executeCreatePayment(PaymentRequest request) async {
    return await repository.createPayment(request);
  }

  Future<int> executeGetUserId() async {
    return await repository.getUserId();
  }

  Future<List<Variant>> executeGetProductVariants(int productId) async {
    return await repository.getProductVariants(productId);
  }

  Future<List<String>> executeGetAvailableColors(int productId) async {
    return await repository.getAvailableColors(productId);
  }

  Future<List<String>> executeGetAvailableSizes(int productId) async {
    return await repository.getAvailableSizes(productId);
  }

  Future<List<String>> executeGetSizesForColor(
      int productId, String color) async {
    return await repository.getSizesForColor(productId, color);
  }

  Future<List<String>> executeGetColorsForSize(
      int productId, String size) async {
    return await repository.getColorsForSize(productId, size);
  }

  Future<VariantDetails> executeGetVariantDetails(
    int productId,
    String color,
    String size,
  ) async {
    return await repository.getVariantDetails(productId, color, size);
  }

  Future<Map<String, dynamic>> executeGetFirstVariantForColor(int productId, String color) async {
    return await repository.getFirstVariantForColor(productId, color);
  }

  Future<ProfiResponse> executeGetProfileUser(int userId) async {
    return await repository.getProfileUser(userId);
  }

  Future<List<PaymentHistoryItem>> getPaymentHistory(int userId) async {
    return await repository.getPaymentHistory(userId);
    }

  Future<List<OrderHistoryItem>> executeGetOrderHistory(int userId) async {
    return await repository.getOrderHistory(userId);
  }

  Future<PredictionResponse> executeGetAverageSpend(int userId) async {
    return await repository.getAverageSpend(userId);
  }

}
