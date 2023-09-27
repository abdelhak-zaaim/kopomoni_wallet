import 'package:flutter/material.dart';
import 'package:six_cash/util/color_resources.dart';

ThemeData dark = ThemeData(
  fontFamily: 'Roboto',
  primaryColor: const Color(0xFF689da7),
  brightness: Brightness.dark,
  secondaryHeaderColor: const Color(0xFFaaa818),
  shadowColor: Colors.black.withOpacity(0.4),
  textTheme: const TextTheme(
    titleLarge: TextStyle(color:Color(0xFF8dbac3)),
    titleSmall: TextStyle(color: Color(0xFF25282D)),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.black, selectedItemColor: ColorResources.themeDarkBackgroundColor),
);
