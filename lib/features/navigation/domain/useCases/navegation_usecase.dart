import 'package:digital_shop/features/navigation/data/models/cart/cart_request.dart';
import 'package:digital_shop/features/navigation/data/models/cart/cart_response.dart';
import 'package:digital_shop/features/navigation/data/models/cart/get_cart_response.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/CategoryStatisticResponse.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/favorites_isFavorite_response.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/favorites_list_request.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/favorites_list_response.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/favorites_request.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/favorites_response.dart';
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
      executeGetFavoritesStatisticsByCategory() async {
    return await repository.getFavoritesStatisticsByCategory();
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
}
