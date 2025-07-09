import 'package:digital_shop/features/navigation/data/datasources/navegation_remote_datasource.dart';
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
import 'package:digital_shop/features/navigation/data/models/profile/profile_response.dart';
import 'package:digital_shop/features/navigation/data/models/variant/VariantDetails_model.dart';
import 'package:digital_shop/features/navigation/domain/repositories/interface/inavegation_repository.dart';

class NavegationRepositoryImpl implements iNavegationRepository {
  final NavegationRemoteDatasource datasource;

  NavegationRepositoryImpl(this.datasource);

  @override
  Future<FavoritesResponse> addFavorite(FavoriteRequest request) {
    return datasource.addFavorite(request);
  }

  @override
  Future<FavoritesResponse> removeFavorite(FavoriteRequest request) {
    return datasource.removeFavorite(request);
  }

  @override
  Future<FavoritesIsFavoriteResponse> isFavorite(FavoriteRequest request) {
    return datasource.isFavorite(request);
  }

  @override
  Future<List<GetFavoritesListResponse>> getFavorites(
      FavoriteListRequest request) {
    return datasource.getFavorites(request);
  }

  @override
  Future<List<CategoryStatisticResponse>> getFavoritesStatisticsByCategory() {
    return datasource.getFavoritesStatisticsByCategory();
  }

  @override
  Future<CartResponse> addToCart(CartRequest request) {
    return datasource.addToCart(request);
  }

  @override
  Future<CartResponse> removeFromCart(CartRequest request) {
    return datasource.removeFromCart(request);
  }

  @override
  Future<List<GetCartItem>> getCartItems(int userId) {
    return datasource.getCartItems(userId);
  }

  @override
  Future<CartResponse> updateQuantity(CartRequest request) {
    return datasource.updateQuantity(request);
  }

  @override
  Future<Map<String, dynamic>> createOrder(OrderRequest request) async {
    return await datasource.createOrder(request);
  }

  @override
  Future<PaymentResponse> createPayment(PaymentRequest request) {
    return datasource.createPayment(request);
  }

  @override
  Future<int> getUserId() {
    return datasource.getUserId();
  }

  @override
  Future<List<Variant>> getProductVariants(int productId) {
    return datasource.getProductVariants(productId);
  }

  @override
  Future<List<String>> getAvailableColors(int productId) {
    return datasource.getAvailableColors(productId);
  }

  @override
  Future<List<String>> getAvailableSizes(int productId) {
    return datasource.getAvailableSizes(productId);
  }

  @override
  Future<List<String>> getSizesForColor(int productId, String color) {
    return datasource.getSizesForColor(productId, color);
  }

  @override
  Future<List<String>> getColorsForSize(int productId, String size) {
    return datasource.getColorsForSize(productId, size);
  }

  @override
  Future<VariantDetails> getVariantDetails(
    int productId,
    String color,
    String size,
  ) {
    return datasource.getVariantDetails(productId, color, size);
  }

  @override
  Future<Map<String, dynamic>> getFirstVariantForColor(
      int productId, String color) {
    return datasource.getFirstVariantForColor(productId, color);
  }

  @override
  Future<ProfiResponse> getProfileUser(int userId) {
    return datasource.getProfileUser(userId);
  }
}
