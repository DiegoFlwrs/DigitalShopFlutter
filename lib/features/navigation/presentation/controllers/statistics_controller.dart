import 'package:digital_shop/core/utils/session_helper.dart';
import 'package:digital_shop/features/navigation/data/models/favorites/CategoryStatisticResponse.dart';
import 'package:digital_shop/features/navigation/data/models/variant/PredictionResult.dart';
import 'package:get/get.dart';
import 'package:digital_shop/features/navigation/domain/useCases/navegation_usecase.dart';

class StatisticsController extends GetxController {
  final NavegationUseCase navegationUseCase;

  StatisticsController(this.navegationUseCase);

  final RxBool isLoading = false.obs;
  final RxList<CategoryStatisticResponse> statistics = <CategoryStatisticResponse>[].obs;

  final Rx<PredictionResponse?> averageSpend = Rx<PredictionResponse?>(null);
  final RxDouble averageSpendValue = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    loadFavoritesStatisticsByCategory();
    //loadAverageSpend(123); // Si querés usar solo la predicción local, podés comentar esta línea
  }

  Future<void> loadFavoritesStatisticsByCategory() async {
    try {
      isLoading.value = true;
      final userId = await SessionHelper.getUserId();
      if (userId != null) {
        final result = await navegationUseCase.executeGetFavoritesStatisticsByCategory(userId);
        statistics.assignAll(result);

        // Aquí hacemos la predicción local con los datos que tenemos
        predictSpendFromFavorites();

      } else {
        print("No se encontró userId en SharedPreferences");
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  // Método para obtener la categoría favorita top
  String? getTopFavoriteCategory() {
  if (statistics.isEmpty) return null;
  // Creamos una copia normal de la lista para ordenar sin afectar el RxList original
  final sortedStats = statistics.toList()
    ..sort((a, b) => b.count.compareTo(a.count));
  return sortedStats.first.categoryName;
}

  // Método para predecir el gasto según la categoría favorita
  void predictSpendFromFavorites() {
    final topCategory = getTopFavoriteCategory();
    if (topCategory == null) {
      averageSpendValue.value = 0.0;
      return;
    }

    // Map con estimaciones por categoría (ajustalo a tus datos)
    final Map<String, double> categorySpendEstimate = {
      'GORRA': 15.0,
      'POLO': 25.0,
      'ZAPATOS': 35.0,
      // Agregá más categorías según necesites
    };

    averageSpendValue.value = categorySpendEstimate[topCategory] ?? 10.0;
  }

  // Opcional: si querés seguir usando la carga remota del promedio
  Future<void> loadAverageSpend(int userId) async {
    try {
      isLoading.value = true;
      final result = await navegationUseCase.executeGetAverageSpend(userId);
      averageSpend.value = result;
      averageSpendValue.value = result.averageSpend;
    } catch (e) {
      print('Error getting average spend: $e');
    } finally {
      isLoading.value = false;
    }
  }
  
}
