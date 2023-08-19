import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: defultolor,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    // centerTitle: true,
    titleTextStyle: TextStyle(
      fontFamily: 'Jan',
      color: Colors.blue,
      fontSize: 25,
      fontWeight: FontWeight.bold,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color(0xff202C33),
      statusBarIconBrightness: Brightness.light,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
      size: 22,
    ),
  ),
  fontFamily: 'Jan',
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.deepOrange,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defultolor,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      fontFamily: 'Jan',
      fontWeight: FontWeight.bold,
      fontSize: 14.0,
      color: Colors.black,
      height: 1.3,
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black87,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontFamily: 'Jan',
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.black87,
      statusBarIconBrightness: Brightness.light,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  scaffoldBackgroundColor: Colors.black87,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.deepOrange,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      fontFamily: 'Jan',
      fontSize: 14.0,
      color: Colors.white,
      height: 1.3,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Jan',
      fontSize: 12.0,
      color: Colors.white,
      height: 1.3,
    ),
  ),
  cardColor: Colors.black87,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black87,
      selectedLabelStyle: TextStyle(
        fontFamily: 'Jan',
        fontSize: 14.0,
        color: Colors.white,
        height: 1.3,
      )),
);
