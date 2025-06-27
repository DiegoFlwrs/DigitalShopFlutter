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

}
