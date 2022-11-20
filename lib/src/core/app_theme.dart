import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData getTheme(BuildContext context) {
    return ThemeData(
      //primarySwatch: Colors.blue,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0Xcc88f3),
      ),
      textTheme: GoogleFonts.poppinsTextTheme(
        Theme.of(context).textTheme,
      ),
    );
  }
}
