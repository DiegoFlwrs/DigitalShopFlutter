import 'package:digital_shop/features/navigation/presentation/controllers/statistics_controller.dart';
import 'package:digital_shop/features/navigation/presentation/widgets/appBar.dart';
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

    final theme = Theme.of(context);

    return Scaffold(
      appBar: const CustomAppBar(),
      // AppBar(
      //   title: const Text("📊 Estadísticas"),
      //   centerTitle: true,
      //   backgroundColor: theme.colorScheme.primary,
      //   foregroundColor: Colors.white,
      //   elevation: 2,
      // ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.statistics.isEmpty) {
          return const Center(
            child: Text(
              '🚫 No hay datos disponibles',
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        final stats = controller.statistics;

        return Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "📦 Productos Favoritos por Categoría",
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.secondary,
                ),
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PieChart(
                      PieChartData(
                        sectionsSpace: 4,
                        centerSpaceRadius: 60,
                        borderData: FlBorderData(show: false),
                        sections: stats.asMap().entries.map((entry) {
                          final index = entry.key;
                          final data = entry.value;
                          final color =
                              Colors.primaries[index % Colors.primaries.length];

                          return PieChartSectionData(
                            color: color.shade400,
                            value: data.count.toDouble(),
                            title: '${data.count}',
                            radius: 90,
                            titleStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            badgeWidget: _Badge(
                              label: data.categoryName,
                              color: color.shade700,
                            ),
                            badgePositionPercentageOffset: 1.2,
                          );
                        }).toList(),
                      ),
                      swapAnimationDuration: const Duration(milliseconds: 600),
                      swapAnimationCurve: Curves.easeInOut,
                    ),
                    const Text(
                      "Categorías",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 🧠 Mostrar predicción debajo del gráfico
              Obx(() {
                final topCategory = controller.getTopFavoriteCategory();
                return Text(
                  topCategory != null
                      ? '🧠 Predicción: Tu prenda favorita es $topCategory'
                      : 'No se pudo determinar tu prenda favorita',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                  textAlign: TextAlign.center,
                );
              }),

              const SizedBox(height: 20),

              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: stats.asMap().entries.map((entry) {
                  final index = entry.key;
                  final data = entry.value;
                  final color =
                      Colors.primaries[index % Colors.primaries.length];

                  return Chip(
                    avatar: CircleAvatar(
                      backgroundColor: color.shade400,
                    ),
                    label: Text('${data.categoryName} (${data.count})'),
                    backgroundColor: color.shade100,
                    labelStyle: const TextStyle(fontSize: 14),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final Color color;

  const _Badge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(1, 2),
            blurRadius: 4,
          )
        ],
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
