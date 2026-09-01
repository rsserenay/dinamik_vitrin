// lib/utils/app_theme.dart
//
// Not: Bu dosya bir "controller" veya "view" değil, sadece statik tema
// verisidir (renk paleti + tipografi tanımı). MVC ayrımını bozmaz; View'lar
// buradaki renklere DOĞRUDAN değil, her zaman Theme.of(context) üzerinden
// erişir. Hiçbir yerde Colors.black / Colors.white widget'a hardcoded verilmez.

import 'package:flutter/material.dart';

class AppThemes {
  AppThemes._();

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF6C5CE7),
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: const Color(0xFFF7F7FB),
    cardColor: Colors.white,
    shadowColor: Colors.black.withValues(alpha: 0.15),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF6C5CE7),
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    cardColor: const Color(0xFF1E1E1E),
    shadowColor: Colors.black.withValues(alpha: 0.4),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
    ),
  );
}
