// lib/main.dart
//
// Aşama 2 kapsamı: Get.changeTheme() ile Dark/Light mod geçişi eklendi.
// Başlangıç teması AppThemes.lightTheme; AppBar'daki ikona basıldığında
// ThemeController.toggleTheme() çağrılır ve tema anında değişir.

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bindings/initial_binding.dart';
import 'utils/app_theme.dart';
import 'views/home_view.dart';

void main() {
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
