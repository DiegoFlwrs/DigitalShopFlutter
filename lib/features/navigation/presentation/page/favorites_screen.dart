import 'package:digital_shop/core/services/api_service.dart';
import 'package:digital_shop/features/navigation/data/datasources/navegation_remote_datasource.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/favorites_request.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/favorites_list_request.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/favorites_list_response.dart';
import 'package:digital_shop/features/navigation/domain/repositories/implement/navegation_repository.dart';
import 'package:digital_shop/features/navigation/domain/useCases/navegation_usecase.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<GetFavoritesListResponse> _favoriteProducts = [];
  bool _isLoading = false;
  late NavegationUseCase _favoriteUseCase;

  @override
  void initState() {
    super.initState();
    _initializeServices();
    _loadFavoriteProducts();
  }

  Future<void> _initializeServices() async {
    final apiService = ApiService();
    final remoteDatasource = NavegationRemoteDatasource(apiService);
    final repository = NavegationRepositoryImpl(remoteDatasource);
    _favoriteUseCase = NavegationUseCase(repository);
  }

  Future<void> _loadFavoriteProducts() async {
    setState(() => _isLoading = true);
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');
    
    if (userId == null) {
      setState(() {
        _isLoading = false;
        _favoriteProducts = [];
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se encontró el ID de usuario')),
      );
      return;
    }

    try {
      final request = FavoriteListRequest(userId: userId);
      final products = await _favoriteUseCase.executeGetFavorites(request);
      
      setState(() {
        _favoriteProducts = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar favoritos: ${e.toString()}')),
      );
    }
  }

  Future<void> _removeFavorite(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');
    if (userId == null) return;

    try {
      final response = await _favoriteUseCase.executeRemoveFavorite(
        FavoriteRequest(userId: userId, productId: productId),
      );

      if (response.status) {
        setState(() {
          _favoriteProducts.removeWhere((product) => product.id == productId);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al eliminar: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Mis Favoritos'),
      //   backgroundColor: Colors.blue,
      // ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _favoriteProducts.isEmpty
              ? const Center(
                  child: Text('No tienes productos favoritos aún.'),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: _favoriteProducts.length,
                    itemBuilder: (context, index) {
                      final product = _favoriteProducts[index];
                      return Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(12)),
                                    child: Image.network(
                                      product.variants.first.imageUrl,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => 
                                        const Center(child: Icon(Icons.broken_image)),
                                  ),
                                  ),
                                  Positioned(
                                    bottom: 8,
                                    right: 8,
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.remove_circle,
                                        color: Colors.red,
                                        size: 28,
                                      ),
                                      onPressed: () => _removeFavorite(product.id),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'S/${product.basePrice.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.remove_red_eye_sharp),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/detail',
                                          arguments: {
                                            'id': product.id,
                                            'name': product.name,
                                            'price': product.basePrice,
                                            "description": product.description,
                                            "imageUrl": product.variants.first.imageUrl,
                                            "category": product.category.name,
                                            "isFavorite": true,
                                          });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}