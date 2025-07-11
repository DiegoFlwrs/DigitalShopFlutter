import 'package:digital_shop/features/navigation/presentation/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:digital_shop/core/constants/app_colors.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final faqs = [
      "¿Cómo hacer un pedido?",
      "¿Cómo pagar con tarjeta?",
      "¿Dónde ver mis facturas?",
      "¿Cómo modificar mi dirección de entrega?",
      "¿Qué métodos de pago aceptan?",
    ];

    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: const CustomAppBar(), 
      // AppBar(
      //   backgroundColor: AppColors.primary,
      //   centerTitle: true,
      //   title: const Text('Centro de Ayuda', style: TextStyle(color: AppColors.white)),
      //   elevation: 2,
      // ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "¿Cómo podemos ayudarte?",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),

          // Barra de búsqueda (estética, no funcional aún)
          Container(
            decoration: BoxDecoration(
              color: AppColors.bgContainer,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))],
            ),
            child: const TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                hintText: "Buscar ayuda...",
                hintStyle: TextStyle(color: Colors.white70),
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search, color: Colors.white70),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),

          const SizedBox(height: 24),
          ...faqs.map((question) => _buildFAQCard(question)).toList(),
        ],
      ),
    );
  }

  Widget _buildFAQCard(String question) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.bgContainer,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: ListTile(
        leading: const Icon(Icons.help_outline, color: AppColors.primary),
        title: Text(
          question,
          style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.white70),
        onTap: () {
          // Puedes mostrar una pantalla o diálogo con la respuesta
        },
      ),
    );
  }
}
