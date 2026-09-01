// lib/firebase_options.dart
//
// ÖNEMLİ: Bu dosya PLACEHOLDER'dır. Gerçek Firebase projesi değerleriyle
// DEĞİŞTİRİLMESİ GEREKİR. Bunu elle yazmak yerine, terminalde proje kökünde:
//
//   dart pub global activate flutterfire_cli
//   flutterfire configure
//
// komutunu çalıştır. Bu komut Firebase Console'daki projenle seni eşleştirir
// ve bu dosyayı GERÇEK apiKey/appId/projectId değerleriyle otomatik yeniden
// oluşturur. O ana kadar bu placeholder değerlerle Firebase.initializeApp()
// başarısız olur; ancak uygulama yine de çökmez (main.dart ve
// RemoteConfigController bunu try/catch ile karşılıyor, default değerlerle
// çalışmaya devam eder).

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (Platform.operatingSystem) {
      case 'android':
        return android;
      case 'ios':
        return ios;
      default:
        return web;
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'REPLACE_ME',
    appId: 'REPLACE_ME',
    messagingSenderId: 'REPLACE_ME',
    projectId: 'REPLACE_ME',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'REPLACE_ME',
    appId: 'REPLACE_ME',
    messagingSenderId: 'REPLACE_ME',
    projectId: 'REPLACE_ME',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'REPLACE_ME',
    appId: 'REPLACE_ME',
    messagingSenderId: 'REPLACE_ME',
    projectId: 'REPLACE_ME',
    iosBundleId: 'com.example.dinamikVitrin',
  );
}