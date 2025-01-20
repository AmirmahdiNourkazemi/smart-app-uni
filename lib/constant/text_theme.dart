import 'package:flutter/material.dart';
import 'package:smartfunding/constant/scheme.dart';

class CustomTextTheme {
  TextTheme getTextTheme(BuildContext context) {
    return const TextTheme(
        // Define various text styles here with different font sizes based on screen size
        titleLarge: TextStyle(fontSize: 14.0, fontFamily: 'IR'
            // Other properties...
            ),
        titleMedium: TextStyle(
            fontSize: 12.0, fontFamily: 'IR', fontWeight: FontWeight.w700
            // Other properties...
            ),
        titleSmall: TextStyle(
            fontSize: 12.0,
            fontFamily: 'IR',
            fontWeight: FontWeight.w400,
            color: Color(0xff808080)
            // Other properties...
            ),
        bodySmall: TextStyle(
            fontSize: 12.0,
            fontFamily: 'IR',
            color: Colors.blue,
            fontWeight: FontWeight.w700),
        displaySmall: TextStyle(
            fontSize: 12.0,
            fontFamily: 'IR',
            color: Colors.white,
            fontWeight: FontWeight.w700),
        labelSmall: TextStyle(
            fontSize: 12,
            fontFamily: 'IR',
            color: Colors.black,
            fontWeight: FontWeight.normal),
        headlineSmall: TextStyle(
          fontFamily: 'IR',
          fontSize: 10,
          color: Color(0xff808080),
        ),
        labelMedium: TextStyle(
          fontFamily: 'IR',
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
        headlineLarge: TextStyle(
          fontFamily: 'IR',
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'IR',
          fontSize: 12,
          color: Color(0xff808080),
        ),
        bodyMedium: TextStyle(
            fontSize: 12.0,
            fontFamily: 'IR',
            color: AppColorScheme.primaryColor,
            fontWeight: FontWeight.w700),
        displayMedium: TextStyle(
          fontFamily: 'IR',
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: 10,
        ),
        displayLarge: TextStyle(
          fontFamily: 'IR',
          fontSize: 8,
          color: Color(0xff808080),
        ));
  }
}
