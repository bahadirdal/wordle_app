import 'package:flutter/material.dart';

import '../constants/colors.dart';

final ThemeData lightTheme = ThemeData(

      primaryColorLight: lighThemeDarkShade,
      primaryColorDark: lighThemeDarkShade,
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )
      ),
      scaffoldBackgroundColor: Colors.white,
      textTheme: const TextTheme().copyWith(
        bodyText2: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),));

final ThemeData darkTheme = ThemeData(

    primaryColorLight: darkThemeDarkShade,
    primaryColorDark: darkThemeDarkShade,
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        )
    ),
    scaffoldBackgroundColor: Colors.black,
    dividerColor: darkThemeLightShade,
    textTheme: TextTheme().copyWith(
      bodyText2: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),));
