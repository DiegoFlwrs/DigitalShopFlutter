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

abstract class iNavegationRepository {
  Future<FavoritesResponse> addFavorite(FavoriteRequest request);

  Future<FavoritesResponse> removeFavorite(FavoriteRequest request);

  Future<FavoritesIsFavoriteResponse> isFavorite(FavoriteRequest request);

  Future<List<GetFavoritesListResponse>> getFavorites(
      FavoriteListRequest request);

  Future<List<CategoryStatisticResponse>> getFavoritesStatisticsByCategory();

  Future<CartResponse> addToCart(CartRequest request);
  
  Future<CartResponse> removeFromCart(CartRequest request);
  
  Future<List<GetCartItem>> getCartItems(int userId);
  
  Future<CartResponse> updateQuantity(CartRequest request);

  Future<Map<String, dynamic>> createOrder(OrderRequest request);
  
  Future<PaymentResponse> createPayment(PaymentRequest request);
  
  Future<int> getUserId();
}
