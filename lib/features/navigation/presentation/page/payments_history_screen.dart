import 'package:digital_shop/core/utils/session_helper.dart';
import 'package:digital_shop/features/navigation/presentation/controllers/historial_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:digital_shop/core/constants/app_colors.dart';
import 'package:digital_shop/features/navigation/presentation/widgets/appBar.dart';

class PaymentsHistoryScreen extends StatefulWidget {
  const PaymentsHistoryScreen({super.key});

  @override
  State<PaymentsHistoryScreen> createState() => _PaymentsHistoryScreenState();
}

class _PaymentsHistoryScreenState extends State<PaymentsHistoryScreen> {
  late OrderHistoryController controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      controller = Provider.of<OrderHistoryController>(context, listen: false);
      final userId = await SessionHelper.getUserId();
      if (userId != null) {
        controller.loadPayments(userId);
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
          if (controller.isLoadingPayments) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.paymentError != null) {
            return Center(child: Text(controller.paymentError!));
          }

          if (controller.payments.isEmpty) {
            return const Center(child: Text("No tienes pagos registrados"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: controller.payments.length,
            itemBuilder: (context, index) {
              final payment = controller.payments[index];

              return Card(
                elevation: 5,
                color: AppColors.bgContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.account_balance_wallet,
                            color: Color.fromARGB(255, 223, 219, 219), size: 28),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              payment.amount,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.calendar_today,
                                    size: 14, color: Color.fromARGB(255, 230, 228, 228)),
                                const SizedBox(width: 4),
                                Text(
                                  payment.date,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Color.fromARGB(255, 230, 228, 228)
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: AppColors.white),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
