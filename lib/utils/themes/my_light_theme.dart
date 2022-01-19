import 'package:flutter/material.dart';

/// Класс настроей цветов преложения
abstract class ColorsLightTheme {
  static const Color scaffoldBackgroundColor =
      Color.fromRGBO(210, 226, 239, 1.0);
  static const Color mainTextColor = Color.fromRGBO(71, 84, 108, 1);
  static const Color textColor = Color.fromRGBO(171, 175, 178, 1);
  static const Color cardColor1 = Color.fromRGBO(242, 76, 78, 1);
  static const Color cardColor2 = Color.fromRGBO(150, 33, 75, 1);
  static const Color cardColor3 = Color.fromRGBO(255, 199, 89, 1);
  static const Color cardColor4 = Color.fromRGBO(79, 199, 254, 1);
}

/// Переменная для переопределения темы приложения
final myLightTheme = ThemeData.light().copyWith();
