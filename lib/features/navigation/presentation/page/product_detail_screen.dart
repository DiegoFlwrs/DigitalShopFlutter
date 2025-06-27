import 'package:digital_shop/core/constants/app_colors.dart';
import 'package:digital_shop/features/auth/presentation/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import '../widgets/color_selector.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String? text;
  // const ProductDetailScreen({
  //   Key? key,
  //   this.text
  // }) : super(key: key);
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final name = args['name'];
    final price = args['price'];
    final description = args['description'];
    final imageUrl = args['imageUrl'];
    final category = args['category'];
    int selectedColor = 0;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(name ?? '', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.arrow_forward),
      //       onPressed: () {
      //         // Redireccionar a otra pantalla
      //         Navigator.pushReplacementNamed(context, '/homeScreen');
      //       },
      //     )
      //   ],
      // ),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            // color: const Color.fromARGB(255, 236, 237, 239),
            color: const Color.fromARGB(255, 236, 237, 239),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            elevation: 8,
            child: Container(
              height: screenHeight / 1.6,
              width: double.maxFinite,
              padding: const EdgeInsets.all(16),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    imageUrl ?? '',
                    fit: BoxFit.cover,
                    width: 500,
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
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                    // const SizedBox(height: 8),
                    Text("\$${price}",
                        style:
                            TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
                  onSelected: (index) {},
                ),
                const SizedBox(height: 90),
                const Center(
                  child:
                  AuthButton(
                    backgroundColor: AppColors.primary,
                    textColor: AppColors.white,
                    borderColor: AppColors.primary,
                    text: "Agregar al carrito",
                    ) 
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
