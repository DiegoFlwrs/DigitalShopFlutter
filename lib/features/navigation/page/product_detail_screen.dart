import 'package:flutter/material.dart';
import '../widgets/color_selector.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int selectedColor = 0;

    return Scaffold(
      appBar: AppBar(title: const Text("Winter Hoody")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text("Winter hoody", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const Text("\$128", style: TextStyle(fontSize: 20, color: Colors.deepOrange)),
            const SizedBox(height: 8),
            const Text("Description", style: TextStyle(fontWeight: FontWeight.bold)),
            const Text("Ultra soft and insulating. Fleece is a resistant material in winter hoodies, avoiding wind."),
            const SizedBox(height: 16),
            const Text("Color", style: TextStyle(fontWeight: FontWeight.bold)),
            ColorSelector(
              colors: const [Colors.black, Colors.red, Colors.blue, Colors.purple],
              selectedIndex: selectedColor,
              onSelected: (index) {},
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
                child: const Text("Add to cart"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
