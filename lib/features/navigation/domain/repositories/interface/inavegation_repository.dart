
import 'package:digital_shop/features/navigation/data/models/favorites/favorites_isFavorite_response.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/favorites_list_request.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/favorites_list_response.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/favorites_request.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/favorites_response.dart';

abstract class iNavegationRepository {
  Future<FavoritesResponse> addFavorite(FavoriteRequest request);

  Future<FavoritesResponse> removeFavorite(FavoriteRequest request);

  Future<FavoritesIsFavoriteResponse> isFavorite(FavoriteRequest request);
  
  Future<List<GetFavoritesListResponse>> getFavorites(FavoriteListRequest request);
}