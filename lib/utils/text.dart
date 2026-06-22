import 'package:flutter/material.dart';

Text appText({
  required String text,
  double fontSize = 18,
  FontWeight fontWeight = FontWeight.normal
}) {
  return Text(
    text,
    style: TextStyle(
      color: Color(0xffDDC6A7),
      fontSize: fontSize,
      fontWeight: fontWeight
    )
  );
}
