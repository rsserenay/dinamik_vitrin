// lib/controllers/theme_controller.dart
//
// Katman: CONTROLLER
// Sorumluluğu: Dark/Light mod durumunu tutmak ve Get.changeTheme() ile
// uygulamanın temasını değiştirmek. View sadece isDarkMode.value'ya bakıp
// hangi ikonu (ay/güneş) göstereceğine karar verir; setState YOKTUR.

import 'package:get/get.dart';
import '../utils/app_theme.dart';

class ThemeController extends GetxController {
  final RxBool isDarkMode = false.obs;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeTheme(isDarkMode.value ? AppThemes.darkTheme : AppThemes.lightTheme);
  }
}
