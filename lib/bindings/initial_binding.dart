// lib/bindings/initial_binding.dart
import 'package:get/get.dart';
import '../controllers/product_controller.dart';
import '../controllers/theme_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ProductController>(ProductController(), permanent: true);
    Get.put<ThemeController>(ThemeController(), permanent: true);
  }
}
