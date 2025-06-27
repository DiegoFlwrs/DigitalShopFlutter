import 'package:digital_shop/features/navigation/presentation/controllers/statistics_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StatisticsController(Get.find()));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadFavoritesStatisticsByCategory();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Estadísticas"),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.statistics.isEmpty) {
          return const Center(child: Text('No hay datos disponibles'));
        }

        final stats = controller.statistics;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                "PRODUCTOS FAVORITOS",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 300, 
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 4,
                    centerSpaceRadius: 50,
                    sections: stats.asMap().entries.map((entry) {
                      final index = entry.key;
                      final data = entry.value;
                      final color =
                          Colors.primaries[index % Colors.primaries.length];

                      return PieChartSectionData(
                        color: color,
                        value: data.count.toDouble(),
                        title: '${data.categoryName}\n${data.count}',
                        radius: 80,
                        titleStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
