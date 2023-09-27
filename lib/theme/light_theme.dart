import 'package:flutter/material.dart';
import 'package:six_cash/util/color_resources.dart';

ThemeData light = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Rubik',
  primaryColor: const Color(0xFF067FDA),
  secondaryHeaderColor: const Color(0xFFFFD700),
  primaryColorDark: Colors.black,
  shadowColor: Colors.grey[300],

  textTheme: const TextTheme(
    titleLarge: TextStyle(color: Color(0xFF003E47)),
    titleSmall: TextStyle(color: Color(0xFF25282D)),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.white,selectedItemColor: ColorResources.themeLightBackgroundColor),

);