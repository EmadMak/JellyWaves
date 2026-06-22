import 'package:flutter/material.dart';
import 'package:jellywaves/utils/text.dart';

Widget redButton({
  required String text,
  required VoidCallback onPressed,
  bool enabled = true,
  double margin = 0
}) {
  return Container(
    height: 50,
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: margin),
    child:  ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xffB83A2E),
        disabledBackgroundColor: Color(0xffdd8078),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        )
      ),
      onPressed: enabled ? onPressed : null,
      child: appText(
        text: text,
        fontWeight: FontWeight.bold
      )
    )
  );
}
