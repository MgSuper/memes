import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  static final lightTheme = ThemeData(
    colorScheme: const ColorScheme.light().copyWith(primary: Colors.white),
    focusColor: Colors.teal,
    primaryColor: Colors.teal,
    listTileTheme: const ListTileThemeData(textColor: Colors.white),
    dividerColor: Colors.white,
    textTheme: GoogleFonts.specialEliteTextTheme().copyWith(
      bodyText1: const TextStyle(color: Colors.white),
      bodyText2: const TextStyle(color: Colors.white),
      button: const TextStyle(color: Colors.white),
      caption: const TextStyle(color: Colors.white),
      subtitle1: const TextStyle(color: Colors.white),
      headline1: const TextStyle(color: Colors.white),
      headline2: const TextStyle(color: Colors.white),
      headline3: const TextStyle(color: Colors.white),
      headline4: const TextStyle(color: Colors.white),
      headline5: const TextStyle(color: Colors.white),
      headline6: const TextStyle(color: Colors.white),
    ),
    scaffoldBackgroundColor: const Color(0xff1e1e24),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xff1e1e24),
      unselectedItemColor: Colors.white,
    ),
    iconTheme: const IconThemeData(color: Colors.teal),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff1e1e24),
      iconTheme: IconThemeData(color: Colors.teal),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: Colors.teal,
      ),
    ),
  );
}
