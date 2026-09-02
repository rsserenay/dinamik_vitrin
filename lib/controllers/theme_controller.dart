import 'package:get/get.dart';
import '../utils/app_theme.dart';

class ThemeController extends GetxController {
  final RxBool isDarkMode = false.obs;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeTheme(isDarkMode.value ? AppThemes.darkTheme : AppThemes.lightTheme);
  }
}
