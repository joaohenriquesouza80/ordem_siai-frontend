import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextMessageWidget extends StatelessWidget {
  final String message;
  final Color color;
  final double height;
  final double fontSize;
  final TextAlign textAlign;
  final FontWeight fontWeight;

  const TextMessageWidget({
    Key? key,
    required this.message,
    required this.color,
    this.height = 80,
    this.fontSize = 14,
    this.textAlign = TextAlign.center,
    this.fontWeight = FontWeight.bold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Center(
        child: Text(
          message,
          textAlign: textAlign,
          style: GoogleFonts.poppins(
            fontWeight: fontWeight,
            fontSize: fontSize,
            color: color,
          ),
        ),
      ),
    );
  }
}
