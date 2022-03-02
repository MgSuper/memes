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
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    colorScheme: const ColorScheme.dark(),
    listTileTheme: const ListTileThemeData(textColor: Colors.white),
    textTheme: GoogleFonts.specialEliteTextTheme().copyWith(
      bodyText1: const TextStyle(color: Colors.white),
      bodyText2: const TextStyle(color: Colors.white),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      unselectedItemColor: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      iconTheme: IconThemeData(color: Colors.teal),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: Colors.teal,
      ),
    ),
  );
}
