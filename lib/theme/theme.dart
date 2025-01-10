import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.teal,
    textTheme: TextTheme(
      titleLarge: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold), // Replaces headline6
      bodyLarge: GoogleFonts.lato(fontSize: 16), // Replaces bodyText1
      bodyMedium: GoogleFonts.lato(fontSize: 14), // Replaces bodyText2
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.teal,
    textTheme: TextTheme(
      titleLarge: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold), // Replaces headline6
      bodyLarge: GoogleFonts.lato(fontSize: 16), // Replaces bodyText1
      bodyMedium: GoogleFonts.lato(fontSize: 14), // Replaces bodyText2
    ),
  );
}
