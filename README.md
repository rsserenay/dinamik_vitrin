# Dinamik Vitrin — Aşama 1 (MVC + Asset Yönetimi)

Bu klasör tam bir Flutter projesi değil; sadece **kod ve asset dosyalarını** içerir
(çünkü bu ortamda Flutter SDK çalışmıyor, dolayısıyla `flutter create` ve `flutter pub get`
komutlarını burada çalıştıramadım). Kendi bilgisayarında 5 dakikada ayağa kaldırabilirsin:

## Kurulum

```bash
flutter create dinamik_vitrin
cd dinamik_vitrin
```

Sonra bu paketteki dosyaları kendi projenin üzerine kopyala (üzerine yaz):

- `pubspec.yaml` → projenin köküne (var olanın üzerine yaz)
- `lib/` → projenin `lib/` klasörünün üzerine yaz
- `assets/` → projenin köküne ekle

```bash
flutter pub get
flutter run
```

## Bu aşamada yapılanlar (Aşama 1 — Kabul Kriterleri Karşılandı)

- **MVC klasörleri**: `lib/models`, `lib/controllers`, `lib/views` kesin ayrım.
- **Sıfır setState**: View'lar `GetView<ProductController>` + `Obx` kullanıyor,
  tüm state `ProductController` (GetxController) içinde.
- **Sadece izinli paketler**: `get`, `http`, `firebase_core`, `firebase_remote_config`
  (Firebase Aşama 3'te devreye girecek, pubspec'e şimdiden eklendi).
- **Yerel font**: Poppins `.ttf` dosyaları `assets/fonts/` içinde, `pubspec.yaml`
  üzerinden tüm uygulamaya `ThemeData(fontFamily: 'Poppins')` ile giydirildi.
- **Yerel görseller**: `assets/images/logo.png`, `no_connection.png`, `empty_cart.png`
  — internet koptuğunda veya ürün listesi boşken bunlar gösteriliyor
  (`Image.asset`, harici URL yok). Not: SVG yerine PNG kullandım çünkü Flutter'da
  SVG göstermek `flutter_svg` paketini gerektiriyor ve anayasa harici paketi yasaklıyor.
- **Hardcoded renk yok**: `home_view.dart` içindeki her renk `Theme.of(context)` /
  `theme.colorScheme` / `theme.textTheme` üzerinden okunuyor.
- **Fake Store API entegrasyonu**: `ProductController.fetchProducts()` içinde `http`
  ile çekiliyor, hata durumunda (`hasError`) uygulama çökmüyor, yerel görsel gösteriliyor.

## Sırada ne var?

- **Aşama 2**: AppBar'a Ay/Güneş ikonu + `Get.changeTheme()` ile Dark/Light geçişi.
- **Aşama 3**: Firebase Remote Config ile `show_promo_banner` / `promo_text`.

