import 'package:digital_shop/core/services/api_service.dart';
import 'package:digital_shop/features/auth/data/models/getProducts/getProducts_response.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/favorites_request.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/favorites_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  final ApiService _apiService;
  final SharedPreferences _prefs;

  FavoriteService(this._apiService, this._prefs);

  Future<FavoritesResponse> toggleFavorite(GetProductResponse product) async {
    final userId = _prefs.getInt('userId');
    if (userId == null) {
      throw Exception('User ID not found in local storage');
    }

    final request = FavoriteRequest(
      userId: userId,
      productId: product.id,
    );

    try {
      final FavoritesResponse response;
      
      if (product.isFavorite) {
        // Llamar a endpoint para remover favorito
        response = await _removeFavorite(request);
      } else {
        // Llamar a endpoint para agregar favorito
        response = await _addFavorite(request);
      }

      // Solo actualizar estado local si la API responde con éxito
      if (response.status) {
        product.isFavorite = !product.isFavorite;
        await _saveFavoriteLocally(product.id, product.isFavorite);
      }

      return response;
    } catch (e) {
      throw Exception('Failed to toggle favorite: $e');
    }
  }

  Future<FavoritesResponse> _addFavorite(FavoriteRequest request) async {
    final json = await _apiService.post('/favorites/add', request.toJson());
    return FavoritesResponse.fromJson(json);
  }

  Future<FavoritesResponse> _removeFavorite(FavoriteRequest request) async {
    final json = await _apiService.post('/favorites/remove', request.toJson());
    return FavoritesResponse.fromJson(json);
  }

  Future<bool> checkFavoriteStatus(int productId) async {
    final userId = _prefs.getInt('userId');
    if (userId == null) return false;

    try {
      final json = await _apiService.post('/favorites/check', {
        'userId': userId,
        'productId': productId,
      });
      return json['isFavorite'] ?? false;
    } catch (e) {
      // Fallback a almacenamiento local si la API falla
      final localFavorites = _prefs.getStringList('favorites') ?? [];
      return localFavorites.contains(productId.toString());
    }
  }

  Future<void> _saveFavoriteLocally(int productId, bool isFavorite) async {
    final favorites = _prefs.getStringList('favorites') ?? [];
    if (isFavorite) {
      if (!favorites.contains(productId.toString())) {
        favorites.add(productId.toString());
      }
    } else {
      favorites.remove(productId.toString());
    }
    await _prefs.setStringList('favorites', favorites);
  }
}