import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData getLightTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.plusJakartaSans(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      ),
      bodyMedium: GoogleFonts.plusJakartaSans(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
    ),
  );
}
