# Dinamik Vitrin

Flutter ve GetX kullanılarak geliştirilmiş, Fake Store API üzerinden ürünleri listeleyen dinamik bir mobil e-ticaret vitrini uygulamasıdır.

Proje; MVC mimarisi, GetX state management, tema yönetimi, Firebase Remote Config, local asset kullanımı ve API entegrasyonunu uygulamalı olarak göstermektedir.

## Özellikler

* MVC mimarisi
* GetX ile state management
* `setState` kullanılmamıştır
* Fake Store API üzerinden dinamik ürün listeleme
* HTTP ile API bağlantısı
* Light / Dark Mode desteği
* ThemeData üzerinden renk ve yazı stili yönetimi
* Firebase Remote Config entegrasyonu
* Uzaktan yönetilebilir kampanya banner'ı
* Local image asset kullanımı
* Local `.ttf` font kullanımı
* API ve Firebase hata yönetimi
* Offline durumda kullanılabilen local hata ve boş durum görselleri

## Kullanılan Teknolojiler

* Flutter
* Dart
* GetX
* HTTP
* Firebase Core
* Firebase Remote Config
* Fake Store API

Proje gereksinimleri doğrultusunda herhangi bir UI paketi veya `google_fonts` kullanılmamıştır.

## Proje Yapısı

```text
lib/
│
├── controllers/
│   ├── product_controller.dart
│   ├── theme_controller.dart
│   └── remote_config_controller.dart
│
├── models/
│   └── product_model.dart
│
├── views/
│   ├── home_view.dart
│   └── promo_banner.dart
│
├── utils/
│   └── app_theme.dart
│
├── firebase_options.dart
└── main.dart

assets/
├── fonts/
│   ├── Roboto-Regular.ttf
│   ├── Roboto-Medium.ttf
│   └── Roboto-Bold.ttf
│
└── images/
    ├── empty_cart.png
    └── no_connection.png
```

## MVC Mimarisi

### Model

API'den gelen ürün verilerinin yapısını temsil eder.

`ProductModel` ürün ID'si, başlık, fiyat, açıklama, kategori ve görsel gibi bilgileri içerir.

### Controller

Uygulamanın iş mantığından sorumludur.

* `ProductController`
* `ThemeController`
* `RemoteConfigController`

View içerisinde API isteği, tema değiştirme veya Firebase işlemleri gerçekleştirilmez.

### View

Kullanıcı arayüzünü oluşturur.

View'lar Controller içerisindeki reactive değerleri `Obx` ile dinleyerek gerekli UI'ı oluşturur.

## Fake Store API

Ürünler Fake Store API üzerinden alınmaktadır.

```text
https://fakestoreapi.com/products
```

API işlemleri `ProductController` içerisinde gerçekleştirilir.

Uygulama loading, success, error ve empty durumlarını ayrı şekilde yönetmektedir.

## Tema Yönetimi

Uygulamada Light ve Dark olmak üzere iki tema bulunmaktadır.

Tema değiştirme işlemi `ThemeController` içerisinde gerçekleştirilir.

```dart
Get.changeTheme(...)
```

kullanılarak aktif `ThemeData` değiştirilir.

View içerisinde doğrudan sabit renkler kullanmak yerine aktif temadan renk ve yazı stilleri alınmaktadır.

Bu sayede tema değiştirildiğinde UI yeni temaya uyum sağlar.

## Firebase Remote Config

Uygulamada kampanya banner'ının uzaktan kontrol edilebilmesi için Firebase Remote Config kullanılmıştır.

Firebase Console üzerinde iki parametre bulunmaktadır:

```text
show_promo_banner
Type: Boolean

promo_text
Type: String
```

Örneğin:

```text
show_promo_banner = true
promo_text = "Tüm ürünlerde %20 indirim!"
```

olduğunda kampanya banner'ı gösterilir.

`show_promo_banner` değeri `false` olduğunda banner gizlenir.

Kampanya metni değiştirildiğinde uygulamanın yeniden build edilmesi veya mağazaya yeni sürüm gönderilmesi gerekmez.

### Firebase Başlangıcı

Firebase uygulama başlangıcında başlatılır:

```dart
Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```

Firebase bağlantısında problem oluşması durumunda uygulamanın çökmesini önlemek için hata yakalama mekanizması bulunmaktadır.

### Remote Config Akışı

```text
Firebase Console
        ↓
Remote Config
        ↓
fetchAndActivate()
        ↓
RemoteConfigController
        ↓
Rx değerleri
        ↓
Obx
        ↓
PromoBanner
        ↓
UI
```

Remote Config değerleri alınamazsa uygulama varsayılan değerleri kullanır.

## Asset Yönetimi

Uygulamada internet bağlantısına ihtiyaç duymayan bazı görseller local asset olarak tutulmaktadır.

```text
assets/images/no_connection.png
assets/images/empty_cart.png
```

Dinamik ürün görselleri API'den geldiği için `Image.network()` kullanılır.

Hata ve boş durum görselleri uygulamanın içerisinde bulunduğu için `Image.asset()` kullanılır.

Bu sayede internet bağlantısı olmadığında bile temel hata ve boş durum görselleri gösterilebilir.

## Font Yönetimi

Projede `google_fonts` paketi kullanılmamıştır.

Roboto font dosyaları `.ttf` formatında projeye eklenmiş ve `assets/fonts/` klasöründe tutulmuştur.

Font `pubspec.yaml` içerisinde tanımlanarak uygulama temasına global olarak uygulanmıştır.

## Kurulum

Projeyi klonladıktan sonra:

```bash
flutter pub get
```

Uygulamayı çalıştırmak için:

```bash
flutter run
```

Firebase yapılandırması için FlutterFire tarafından oluşturulan `firebase_options.dart` dosyası kullanılmaktadır.

## Kod Kalitesi

Proje gereksinimleri doğrultusunda:

* `setState` kullanılmamıştır.
* State yönetimi GetX ile yapılmıştır.
* İş mantığı Controller katmanında tutulmuştur.
* UI katmanında doğrudan API işlemleri yapılmamıştır.
* Sabit UI renkleri yerine ThemeData kullanılmıştır.
* Firebase hatalarında varsayılan değerler kullanılmıştır.
* Statik görseller local asset olarak paketlenmiştir.

## Lisans

Bu proje MIT License altında lisanslanmıştır.

Detaylar için `LICENSE` dosyasına bakabilirsiniz.
