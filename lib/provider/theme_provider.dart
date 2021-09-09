import 'package:flutter/material.dart';

class MainTheme {
  static final dark = ThemeData(
      scaffoldBackgroundColor: Color.fromRGBO(10, 10, 50, 1),
      colorScheme: ColorScheme.dark());
  static final light = ThemeData(
      scaffoldBackgroundColor: Colors.white, colorScheme: ColorScheme.light());
}
