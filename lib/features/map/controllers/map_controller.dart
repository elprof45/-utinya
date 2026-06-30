import 'package:get/get.dart';
import 'package:egliloo/data/datasources/local/mock_data.dart';

class MapController extends GetxController {
  final countries = <Map<String, dynamic>>[].obs;
  final selectedCountry = Rxn<Map<String, dynamic>>();
  final selectedRegion = 'Tout'.obs;

  @override
  void onInit() {
    super.onInit();
    countries.value = MockData.africanCountries;
  }

  void selectCountry(Map<String, dynamic> c) => selectedCountry.value = c;
  void clearSelection() => selectedCountry.value = null;
}
