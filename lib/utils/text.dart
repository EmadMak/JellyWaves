import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Text appText({
  required String text,
  double fontSize = 18,
  FontWeight fontWeight = FontWeight.normal,
  Color color = const Color(0xffDDC6A7)
}) {
  return Text(
    text,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.oxanium(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight
    )
  );
}
