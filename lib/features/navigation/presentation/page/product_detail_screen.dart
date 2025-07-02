import 'package:digital_shop/features/navigation/presentation/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:digital_shop/core/constants/app_colors.dart';
import 'package:digital_shop/core/services/api_service.dart';
import 'package:digital_shop/features/auth/presentation/widgets/auth_button.dart';
import 'package:digital_shop/features/navigation/data/datasources/navegation_remote_datasource.dart';
import 'package:digital_shop/features/navigation/domain/repositories/implement/navegation_repository.dart';
import 'package:digital_shop/features/navigation/domain/useCases/navegation_usecase.dart';
import 'package:digital_shop/features/navigation/presentation/controllers/cart_controller.dart';
import 'package:digital_shop/features/navigation/presentation/controllers/variants_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/color_selector.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late CartController _cartController;
  late VariantsController _variantsController;
  int selectedColorIndex = 0;
  int quantity = 1;
  String? selectedColor;
  String? selectedSize;
  List<String> availableColors = [];
  List<String> availableSizes = [];
  bool isLoadingColors = false;
  bool isLoadingSizes = false;

  // Nuevas variables para manejar los datos dinámicos
  String currentImageUrl = '';
  double currentPrice = 0;
  bool isLoadingVariant = false;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  Future<void> _initializeControllers() async {
    final prefs = await SharedPreferences.getInstance();
    final apiService = ApiService();
    final remoteDatasource = NavegationRemoteDatasource(apiService);
    final repository = NavegationRepositoryImpl(remoteDatasource);
    final useCase = NavegationUseCase(repository);

    setState(() {
      _cartController = CartController(useCase, prefs);
      _variantsController = VariantsController(useCase);
    });

    // Inicializar con los valores del argumento
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    setState(() {
      currentImageUrl = args['imageUrl'] ?? '';
      currentPrice = (args['price'] as num).toDouble();
    });

    _loadAvailableColors();
  }

  Future<void> _loadAvailableColors() async {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final productId = args['id'];

    setState(() => isLoadingColors = true);
    try {
      final colors = await _variantsController.getAvailableColors(productId);
      setState(() {
        availableColors = colors;
        if (colors.isNotEmpty) {
          selectedColor = colors.first;
          _loadVariantDetails(selectedColor!);
        }
      });
    } finally {
      setState(() => isLoadingColors = false);
    }
  }

  Future<void> _loadVariantDetails(String color) async {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final productId = args['id'];

    setState(() {
      isLoadingVariant = true;
      selectedSize = null;
    });

    try {
      // Obtener detalles de la primera variante disponible para este color
      final variantDetails = await _variantsController.getFirstVariantForColor(
        productId,
        color,
        context,
      );

      if (variantDetails != null) {
        setState(() {
          currentImageUrl = variantDetails.imageUrl ?? currentImageUrl;
          currentPrice = variantDetails.price;
          availableSizes = variantDetails.availableSizes;
          if (availableSizes.isNotEmpty) {
            selectedSize = availableSizes.first;
          }
        });
      }
    } finally {
      setState(() => isLoadingVariant = false);
    }
  }

  Future<void> _addToCart(BuildContext context) async {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final productId = args['id'];

    if (selectedColor == null || selectedSize == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor selecciona color y talla')),
      );
      return;
    }

    final variantDetails = await _variantsController.getVariantDetails(
      productId,
      selectedColor!,
      selectedSize!,
      context,
    );

    if (variantDetails == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('No se encontró la variante seleccionada')),
      );
      return;
    }

    if (variantDetails.stock < quantity) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Solo quedan ${variantDetails.stock} unidades disponibles')),
      );
      return;
    }

    await _cartController.addToCart(
      variantId: variantDetails.id,
      context: context,
      quantity: quantity,
    );
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final name = args['name'];
    final description = args['description'];
    final category = args['category'];
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: screenHeight / 2.6,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Card(
                color: const Color.fromARGB(255, 236, 237, 239),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
                ),
                elevation: 8,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: isLoadingVariant
                        ? const CircularProgressIndicator()
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.network(
                              currentImageUrl,
                              fit: BoxFit.cover,
                              width: 500,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Center(child: Icon(Icons.broken_image)),
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(name ?? '',
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                      Text("\$${currentPrice.toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 7, // 70%
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Descripción",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              description ?? "",
                              softWrap: true,
                              overflow: TextOverflow.visible,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16), // espacio entre columnas
                      Expanded(
                        flex: 3, // 30%
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Categoría",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              category ?? "",
                              softWrap: true,
                              overflow: TextOverflow.visible,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Selector de Color
                  const Text("Color",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  isLoadingColors
                      ? const CircularProgressIndicator()
                      : ColorSelector(
                          colors: availableColors,
                          selectedIndex:
                              availableColors.indexOf(selectedColor ?? ''),
                          onSelected: (index) {
                            final newColor = availableColors[index];
                            setState(() {
                              selectedColor = newColor;
                            });
                            _loadVariantDetails(newColor);
                          },
                        ),

                  const SizedBox(height: 16),

                  // Selector de Talla y Cantidad
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Selector de Talla
                          Expanded(
                            flex: 6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Talla",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  height: 50,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.primary,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: DropdownButton<String>(
                                    value: selectedSize,
                                    isExpanded: true,
                                    underline: const SizedBox(),
                                    items: availableSizes.map((size) {
                                      return DropdownMenuItem(
                                        value: size,
                                        child: Text(
                                          size,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (newSize) {
                                      setState(() {
                                        selectedSize = newSize;
                                      });
                                    },
                                    hint: const Text('Selecciona talla'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),

                          // Selector de Cantidad
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Unidades",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.primary,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove,
                                            size: 20),
                                        onPressed: () {
                                          if (quantity > 1) {
                                            setState(() {
                                              quantity--;
                                            });
                                          }
                                        },
                                      ),
                                      Text(
                                        quantity.toString(),
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.add, size: 20),
                                        onPressed: () {
                                          setState(() {
                                            quantity++;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Botón de Agregar al Carrito
                  Center(
                    child: AuthButton(
                      backgroundColor: AppColors.primary,
                      textColor: AppColors.white,
                      borderColor: AppColors.primary,
                      text: "Agregar al carrito",
                      onPressed: () => _addToCart(context),
                    ),
                  ),
                  const SizedBox(height: 20), // Espacio adicional al final
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}