import 'package:get/get.dart';
import 'package:egliloo/features/library/controllers/library_controller.dart';

class LibraryBinding extends Bindings {
  @override
  void dependencies() =>
      Get.lazyPut<LibraryController>(() => LibraryController());
}
