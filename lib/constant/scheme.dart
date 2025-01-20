import 'package:flutter/material.dart';

class AppColorScheme {
  //static const Color primaryColor = Color(0xFF074EA0);
  static const Color primaryColor = Color(0xFF074EA0);
  static const Color accentColor = Color(0xFF4CC9F0);
  static const Color scafoldCollor = Color(0xffF9F9F9);
  static const Color greyColor = Color(0xffD8D8D8);
  static const ColorScheme appColorScheme = ColorScheme(
    primary: primaryColor,
    secondary: accentColor,
    surface: scafoldCollor,
    background: scafoldCollor,
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Colors.black,
    onBackground: Colors.black,
    onError: Colors.white,
    brightness: Brightness.light,
  );
}
