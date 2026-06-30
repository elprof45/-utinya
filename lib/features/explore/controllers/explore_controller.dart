import 'package:get/get.dart';
import 'package:egliloo/data/datasources/local/mock_data.dart';
import 'package:egliloo/data/models/content_model.dart';
import 'package:egliloo/data/models/category_model.dart';

class ExploreController extends GetxController {
  final isLoading = true.obs;
  final categories = <CategoryModel>[].obs;
  final allContent = <ContentModel>[].obs;

  final selectedRegion = 'Tout'.obs;

  final List<String> regions = const [
    'Tout',
    'Afrique de l\'Ouest',
    'Afrique Centrale',
    'Afrique de l\'Est',
    'Afrique Australe',
    'Afrique du Nord',
  ];

  static const Map<String, AfricanRegion> _regionMap = {
    'Afrique de l\'Ouest': AfricanRegion.westAfrica,
    'Afrique Centrale': AfricanRegion.centralAfrica,
    'Afrique de l\'Est': AfricanRegion.eastAfrica,
    'Afrique Australe': AfricanRegion.southernAfrica,
    'Afrique du Nord': AfricanRegion.northAfrica,
  };

  @override
  void onInit() {
    super.onInit();
    _load();
  }

  Future<void> _load() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(milliseconds: 500));

      categories.assignAll(MockData.categories);
      allContent.assignAll(MockData.contents);
    } catch (e) {
      categories.clear();
      allContent.clear();
      Get.log('Erreur load ExploreController: $e');
    } finally {
      isLoading.value = false;
    }
  }

  List<ContentModel> get filteredContent {
    final region = selectedRegion.value;

    if (region == 'Tout') {
      return allContent.toList();
    }

    final mappedRegion = _regionMap[region];
    if (mappedRegion == null) {
      return allContent.toList();
    }

    return allContent.where((c) => c.region == mappedRegion).toList();
  }

  void setRegion(String region) {
    if (regions.contains(region)) {
      selectedRegion.value = region;
    }
  }
}
