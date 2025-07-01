import 'package:digital_shop/core/constants/app_colors.dart';
import 'package:digital_shop/core/services/api_service.dart';
import 'package:digital_shop/features/auth/presentation/widgets/auth_button.dart';
import 'package:digital_shop/features/navigation/data/datasources/navegation_remote_datasource.dart';
import 'package:digital_shop/features/navigation/domain/repositories/implement/navegation_repository.dart';
import 'package:digital_shop/features/navigation/domain/useCases/navegation_usecase.dart';
import 'package:digital_shop/features/navigation/presentation/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/color_selector.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late CartController _cartController;
  int selectedColor = 0;
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  Future<void> _initializeController() async {
    final prefs = await SharedPreferences.getInstance();
    final apiService = ApiService();
    final remoteDatasource = NavegationRemoteDatasource(apiService);
    final repository = NavegationRepositoryImpl(remoteDatasource);
    final useCase = NavegationUseCase(repository);
    
    setState(() {
      _cartController = CartController(useCase, prefs);
    });
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final name = args['name'];
    final price = args['price'];
    final description = args['description'];
    final imageUrl = args['imageUrl'];
    final category = args['category'];
    final productId = args['id'];
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          Card(
            color: const Color.fromARGB(255, 236, 237, 239),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            elevation: 8,
            child: Container(
              height: screenHeight / 1.8,
              width: double.maxFinite,
              padding: const EdgeInsets.all(16),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    imageUrl ?? '',
                    fit: BoxFit.cover,
                    width: 500,
                    errorBuilder: (context, error, stackTrace) =>
                        const Center(child: Icon(Icons.broken_image)),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
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
                    Text("\$$price",
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Descripción",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(description ?? ""),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Categoria",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(category ?? ""),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 16),
                const Text("Color",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                ColorSelector(
                  colors: const [
                    Colors.black,
                    Colors.red,
                    Colors.blue,
                    Colors.purple
                  ],
                  selectedIndex: selectedColor,
                  onSelected: (index) {
                    setState(() {
                      selectedColor = index;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
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
                      style: const TextStyle(fontSize: 18),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: AuthButton(
                    backgroundColor: AppColors.primary,
                    textColor: AppColors.white,
                    borderColor: AppColors.primary,
                    text: "Agregar al carrito",
                    onPressed: () async {
                      if (_cartController != null) {
                        await _cartController.addToCart(
                          productId: productId,
                          context: context,
                          quantity: quantity,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}