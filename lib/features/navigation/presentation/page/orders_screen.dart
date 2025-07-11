import 'package:digital_shop/core/utils/session_helper.dart';
import 'package:digital_shop/features/navigation/presentation/controllers/historial_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:digital_shop/core/constants/app_colors.dart';
import 'package:digital_shop/features/navigation/presentation/widgets/appBar.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late OrderHistoryController controller;

  @override
  void initState() {
    super.initState();
    // Espera a que el frame actual termine antes de ejecutar loadOrders
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      controller = Provider.of<OrderHistoryController>(context, listen: false);
      final userId = await SessionHelper.getUserId();
      if (userId != null) {
        controller.loadOrders(userId);
      } else {
        print("No se encontró userId en SharedPreferences");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: const CustomAppBar(),
      body: Consumer<OrderHistoryController>(
        builder: (context, controller, _) {
          if (controller.isLoadingOrders) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.orderError != null) {
            return Center(child: Text(controller.orderError!));
          }
          if (controller.orders.isEmpty) {
            return const Center(child: Text('No tienes pedidos'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: controller.orders.length,
            itemBuilder: (context, index) {
              final order = controller.orders[index];

              Color statusColor;
              switch (order.status) {
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
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                color: const Color.fromARGB(255, 187, 156, 143),
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
                    child: const Icon(Icons.shopping_bag,
                        color: Color.fromARGB(255, 223, 219, 219)),
                  ),
                  title: Text(
                    order.title,
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
                          const Icon(Icons.calendar_today,
                              size: 14, color: Color.fromARGB(255, 223, 219, 219)),
                          const SizedBox(width: 4),
                          Text(
                            order.date,
                            style: const TextStyle(
                                fontSize: 13, color: Color.fromARGB(255, 223, 219, 219)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.info_outline,
                              size: 14, color: Colors.white),
                          const SizedBox(width: 4),
                          const Text(
                            "Estado: ",
                            style: TextStyle(fontSize: 13, color: Colors.white),
                          ),
                          Text(
                            order.status,
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
                  trailing:
                      const Icon(Icons.chevron_right, color: AppColors.white),
                  onTap: () {
                    // Navegar a detalles del pedido si quieres
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
