// lib/controllers/remote_config_controller.dart
//
// Katman: CONTROLLER
// Sorumluluğu: Firebase Remote Config'ten 'show_promo_banner' (bool) ve
// 'promo_text' (String) değerlerini asenkron çekmek. İnternet yoksa veya
// Firebase'e ulaşılamazsa uygulama ÇÖKMEZ; default değerler kullanılır.

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get.dart';

class RemoteConfigController extends GetxController {
  // "default (varsayılan)" değerler — Firebase'e hiç ulaşılamasa bile
  // uygulama bu değerlerle çalışmaya devam eder.
  static const bool _defaultShowBanner = false;
  static const String _defaultPromoText = '';

  final RxBool showPromoBanner = _defaultShowBanner.obs;
  final RxString promoText = _defaultPromoText.obs;
  final RxBool isReady = false.obs;

  @override
  void onInit() {
    super.onInit();
    _fetchRemoteConfig();
  }

  Future<void> _fetchRemoteConfig() async {
    try {
      final remoteConfig = FirebaseRemoteConfig.instance;

      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: const Duration(minutes: 1),
        ),
      );

      await remoteConfig.setDefaults({
        'show_promo_banner': _defaultShowBanner,
        'promo_text': _defaultPromoText,
      });

      await remoteConfig.fetchAndActivate();

      showPromoBanner.value = remoteConfig.getBool('show_promo_banner');
      promoText.value = remoteConfig.getString('promo_text');
    } catch (_) {
      // İnternet yok / Firebase'e ulaşılamıyor / Firebase henüz kurulmamış
      // (firebase_options.dart placeholder) -> sessizce default değerlere düş.
      showPromoBanner.value = _defaultShowBanner;
      promoText.value = _defaultPromoText;
    } finally {
      isReady.value = true;
    }
  }
}