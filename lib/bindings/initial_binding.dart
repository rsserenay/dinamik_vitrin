import 'package:get/get.dart';
import '../controllers/product_controller.dart';
import '../controllers/theme_controller.dart';
import '../controllers/remote_config_controller.dart';

class InitialBinding extends Bindings {
  @override 
  void dependencies() {
    Get.put<ProductController>(ProductController(), permanent: true);
    Get.put<ThemeController>(ThemeController(), permanent: true);
    Get.put<RemoteConfigController>(RemoteConfigController(), permanent: true);
  }
}