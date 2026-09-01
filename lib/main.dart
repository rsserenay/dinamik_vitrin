// lib/main.dart
//
// Aşama 3 kapsamı: Firebase.initializeApp() eklendi. Firebase'e ulaşılamazsa
// (internet yok, henüz `flutterfire configure` çalıştırılmadı vb.) uygulama
// ÇÖKMEZ; try/catch ile yutulur ve RemoteConfigController zaten kendi
// içinde default değerlere düşer.

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'bindings/initial_binding.dart';
import 'firebase_options.dart';
import 'utils/app_theme.dart';
import 'views/home_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (_) {
    // Hata Toleransı: Firebase kurulmamış/erişilemiyor olsa bile uygulama
    // açılmaya devam eder; Remote Config default değerlerle çalışır.
  }

  runApp(const DinamikVitrinApp());
}

class DinamikVitrinApp extends StatelessWidget {
  const DinamikVitrinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Dinamik Vitrin',
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(),
      theme: AppThemes.lightTheme,
      home: const HomeView(),
    );
  }
}