import 'package:flutter/material.dart';
import 'package:jellywaves/utils/text.dart';

Widget settingsBox({required String title, required List<Widget> items}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      appText(text: title),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xff1E1E1E),
          borderRadius: BorderRadius.circular(10),
          border: BoxBorder.all(
            color: Color(0xffDDC6A7).withValues(alpha: 0.3),
            width: 0.5
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < items.length; i++) ...[
              items[i],
              if (i != items.length - 1)
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xffDDC6A7),
                )
            ]
          ]
        )
      )
    ]
  );
}
