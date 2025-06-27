import 'package:digital_shop/features/navigation/data/datasources/navegation_remote_datasource.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/CategoryStatisticResponse.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/favorites_isFavorite_response.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/favorites_list_request.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/favorites_list_response.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/favorites_request.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/favorites_response.dart';
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
  Future<List<GetFavoritesListResponse>> getFavorites(FavoriteListRequest request) {
    return datasource.getFavorites(request);
  }

  @override
  Future<List<CategoryStatisticResponse>> getFavoritesStatisticsByCategory() {
  return datasource.getFavoritesStatisticsByCategory();
}

}