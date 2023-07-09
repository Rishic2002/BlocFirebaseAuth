import 'package:flutter/material.dart';

class AppTheme {
  static const String _poppins = 'Poppins';

  final light = ThemeData(
    backgroundColor: Color.fromRGBO(151, 210, 236, 1.0),
    primaryColor: Color.fromRGBO(151, 210, 236, 1.0),
    appBarTheme: AppBarTheme(
      color: Color.fromRGBO(151, 210, 236, 1.0),
      toolbarTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: const Color.fromRGBO(95, 111, 148, 1.0),
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      bodyText2: TextStyle(
        color: Colors.grey,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color.fromRGBO(95, 111, 148, 1.0)),
  );

  final dark = ThemeData(
    backgroundColor: Color.fromRGBO(37, 49, 109, 1.0),
    primaryColor: Color.fromRGBO(37, 49, 109, 1.0),
    appBarTheme: AppBarTheme(
      color: Color.fromRGBO(37, 49, 109, 1.0),
      toolbarTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: Color.fromRGBO(95, 111, 148, 1.0),
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      bodyText2: TextStyle(
        color: Colors.grey,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
