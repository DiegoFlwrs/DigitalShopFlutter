import 'package:flutter/material.dart';
import 'package:digital_shop/core/constants/app_colors.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = [
      {"title": "Pedido #001", "status": "Entregado", "date": "10 Jul 2025"},
      {"title": "Pedido #002", "status": "En camino", "date": "09 Jul 2025"},
      {"title": "Pedido #003", "status": "Preparando", "date": "08 Jul 2025"},
    ];

    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Mis Pedidos',
          style: TextStyle(color: AppColors.white),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];

          Color statusColor;
          switch (order["status"]) {
            case "Entregado":
              statusColor = Colors.green;
              break;
            case "En camino":
              statusColor = Colors.orange;
              break;
            default:
              statusColor = Colors.blue;
          }

          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: AppColors.bgContainer,
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Container(
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(10),
                child: const Icon(Icons.shopping_bag, color: AppColors.primary),
              ),
              title: Text(
                order["title"]!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.white,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        order["date"]!,
                        style: const TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.info_outline, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      const Text(
                        "Estado: ",
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      Text(
                        order["status"]!,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: const Icon(Icons.chevron_right, color: AppColors.white),
              onTap: () {
                // Aquí podrías navegar a una pantalla con más detalles del pedido
              },
            ),
          );
        },
      ),
    );
  }
}
