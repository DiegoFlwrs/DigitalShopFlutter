import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String image;
  final double price;

  const ProductCard({super.key, required this.title, required this.image, required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          Image.asset(image, height: 100, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Text('\$$price', style: const TextStyle(color: Colors.deepOrange)),
        ],
      ),
    );
  }
}
