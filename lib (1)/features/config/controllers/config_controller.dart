import 'package:get/get.dart';
import '../../../app/data/models/category_model.dart';
import '../../../app/data/providers/mock_data_provider.dart';
import '../../../app/routes/app_routes.dart';

class ConfigController extends GetxController {
  final List<CategoryModel> interests = MockDataProvider.categories;
  final RxList<String> selectedInterests = <String>[].obs;
  final RxString selectedLanguage = 'English'.obs;
  final List<String> languages = MockDataProvider.languages;

  bool isSelected(String id) => selectedInterests.contains(id);

  void toggleInterest(String id) {
    if (selectedInterests.contains(id)) {
      selectedInterests.remove(id);
    } else {
      selectedInterests.add(id);
    }
  }

  void selectLanguage(String? lang) {
    if (lang != null) selectedLanguage.value = lang;
  }

  void continueAction() {
    if (selectedInterests.isEmpty) {
      Get.snackbar(
        'Choose your interests',
        'Please select at least one category to personalize your experience.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    Get.toNamed(Routes.auth);
  }
}
