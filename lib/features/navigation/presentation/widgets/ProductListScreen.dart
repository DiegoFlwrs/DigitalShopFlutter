import 'dart:convert';
import 'package:digital_shop/core/constants/app_colors.dart';
import 'package:digital_shop/core/services/api_service.dart';
import 'package:digital_shop/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:digital_shop/features/auth/data/models/getProducts/getProducts_response.dart';
import 'package:digital_shop/features/auth/domain/repositories/implement/auth_repository.dart';
import 'package:digital_shop/features/auth/domain/useCases/login_usecase.dart';
import 'package:digital_shop/features/auth/presentation/controllers/getProducts_controller.dart';
import 'package:digital_shop/features/auth/presentation/widgets/auth_button.dart';
import 'package:digital_shop/features/auth/presentation/widgets/text_field.dart';
import 'package:digital_shop/features/navigation/data/datasources/navegation_remote_datasource.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/favorites_request.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/favorites_response.dart';
import 'package:digital_shop/features/navigation/domain/repositories/implement/navegation_repository.dart';
import 'package:digital_shop/features/navigation/domain/useCases/navegation_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<GetProductResponse> _products = [];
  bool _isLoading = false;
  late NavegationUseCase _favoriteUseCase;
  final controller = GetProductsController(
    LoginUseCase(
      AuthRepositoryImpl(
        AuthRemoteDatasource(ApiService()),
      ),
    ),
  );

  @override
  void initState() {
    super.initState();
    _initializeServices();
    _loadProductsFromStorage();
  }

  static List<GetProductResponse> _parseProducts(List<String> productsJsonList) {
  return productsJsonList.map((jsonStr) {
    try {
      return GetProductResponse.fromJson(jsonDecode(jsonStr));
    } catch (e) {
      debugPrint('Error parsing product: $e');
      return null;
    }
  }).whereType<GetProductResponse>().toList();
}

  Future<void> _initializeServices() async {
    // final prefs = await SharedPreferences.getInstance();
    final apiService = ApiService();
    final remoteDatasource = NavegationRemoteDatasource(apiService);
    final repository = NavegationRepositoryImpl(remoteDatasource);
    _favoriteUseCase = NavegationUseCase(repository);
  }

  Future<void> _loadProductsFromStorage() async {
    try {
      if (mounted) setState(() => _isLoading = true);

      final prefs = await SharedPreferences.getInstance();
      final productsJsonList = prefs.getStringList('products') ?? [];

      if (productsJsonList.isEmpty) {
        if (mounted)
          setState(() {
            _products = [];
            _isLoading = false;
          });
        return;
      }

      Future<void> _checkFavoritesStatus(List<GetProductResponse> products) async {
  final prefs = await SharedPreferences.getInstance();
  final userId = prefs.getInt('userId');
  
  if (userId == null) {
    products.forEach((p) => p.isFavorite = false);
    return;
  }

  // Procesar en lotes para no saturar
  for (var i = 0; i < products.length; i += 10) {
    final batch = products.sublist(i, i + 10 > products.length ? products.length : i + 10);
    await Future.wait(batch.map((product) async {
      try {
        final response = await _favoriteUseCase.executeIsFavorite(
          FavoriteRequest(userId: userId, productId: product.id),
        );
        product.isFavorite = response.isFavorite;
      } catch (e) {
        product.isFavorite = false;
      }
    }));
  }
}

      // Procesar en bloques para no saturar el hilo principal
      final loadedProducts = await compute(_parseProducts, productsJsonList);

      // Verificar favoritos (optimizado)
      await _checkFavoritesStatus(loadedProducts);

      if (mounted) {
        setState(() {
          _products = loadedProducts;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading products: $e');
      if (mounted) {
        setState(() {
          _products = [];
          _isLoading = false;
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar productos: ${e.toString()}')),
      );
    }
  }

  Future<void> _searchProducts() async {
    setState(() => _isLoading = true);
    try {
      await controller.getProductsSearch(context);
      await _loadProductsFromStorage();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _toggleFavorite(GetProductResponse product) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debes iniciar sesión primero')),
      );
      return;
    }

    final request = FavoriteRequest(
      userId: userId,
      productId: product.id,
    );

    try {
      FavoritesResponse response;
      if (product.isFavorite) {
        response = await _favoriteUseCase.executeRemoveFavorite(request);
      } else {
        response = await _favoriteUseCase.executeAddFavorite(request);
      }

      if (response.status) {
        setState(() {
          product.isFavorite = !product.isFavorite;
        });

        // Actualizar almacenamiento local
        final favorites = prefs.getStringList('favorites') ?? [];
        if (product.isFavorite) {
          if (!favorites.contains(product.id.toString())) {
            favorites.add(product.id.toString());
          }
        } else {
          favorites.remove(product.id.toString());
        }
        await prefs.setStringList('favorites', favorites);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar favorito: $e')),
      );
      // Revertir cambio visual si hay error
      setState(() {
        product.isFavorite = !product.isFavorite;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: CustomTextField(
                      label: 'Buscar',
                      icon: 'search',
                      backgroundColor: AppColors.white,
                      textColor: AppColors.black,
                      borderColor: AppColors.primary,
                      borderWidth: 3.0,
                      borderRadius: 10.0,
                      controller: controller.consultaController,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    flex: 1,
                    child: AuthButton(
                      text: 'BUSCAR',
                      backgroundColor: AppColors.bgPrimary,
                      textColor: AppColors.black,
                      borderColor: AppColors.primary,
                      width: 120,
                      fontSize: 15,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      borderRadius: 10,
                      onPressed: _searchProducts,
                    ),
                  ),
                ],
              ),
            ),
            if (_isLoading)
              const LinearProgressIndicator(
                backgroundColor: Colors.grey,
                color: Colors.blue,
              ),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _products.isEmpty
                      ? const Center(
                          child: Text('No hay productos disponibles.'))
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
                            itemCount: _products.length,
                            itemBuilder: (context, index) {
                              final product = _products[index];
                              return Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.vertical(
                                                    top: Radius.circular(12)),
                                            child: Image.network(
                                              product.variants.first.imageUrl,
                                              // 'https://home.ripley.com.pe/Attachment/WOP_5/2020291550754/2020291550754_2.jpg',
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  const Center(
                                                      child: Icon(
                                                          Icons.broken_image)),
                                            ),
                                          ),
                                          Positioned(
                                            top: 8,
                                            right: 8,
                                            child: IconButton(
                                              icon: Icon(
                                                product.isFavorite
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
                                                color: product.isFavorite
                                                    ? Colors.red
                                                    : Colors.white,
                                                size: 28,
                                              ),
                                              onPressed: () =>
                                                  _toggleFavorite(product),
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
                                            // 👈 Esto evita el overflow
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  product.name,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  '\$${product.basePrice.toStringAsFixed(2)}',
                                                  style: const TextStyle(
                                                      color: Colors.grey),
                                                )
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                                Icons.remove_red_eye_sharp),
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                context,
                                                '/detail',
                                                arguments: {
                                                  'id': product.id,
                                                  'name': product.name,
                                                  'price': product.basePrice,
                                                  "description":
                                                      product.description,
                                                  "imageUrl": product
                                                      .variants.first.imageUrl,
                                                  "category":
                                                      product.category.name,
                                                  "isFavorite":
                                                      product.isFavorite,
                                                },
                                              );
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
            ),
          ],
        ),
      ),
    );
  }
}
