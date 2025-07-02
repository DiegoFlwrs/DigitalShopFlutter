import 'package:digital_shop/features/navigation/data/models/favorites/CategoryStatisticResponse.dart';
import 'package:get/get.dart';
import 'package:digital_shop/features/navigation/domain/useCases/navegation_usecase.dart';

class StatisticsController extends GetxController {
  final NavegationUseCase navegationUseCase;

  StatisticsController(this.navegationUseCase);

  final RxBool isLoading = false.obs;
  final RxList<CategoryStatisticResponse> statistics = <CategoryStatisticResponse>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFavoritesStatisticsByCategory();
  }

  Future<void> loadFavoritesStatisticsByCategory() async {
    try {
      isLoading.value = true;
      final result = await navegationUseCase.executeGetFavoritesStatisticsByCategory();
      statistics.assignAll(result);
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
