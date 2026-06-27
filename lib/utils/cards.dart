import 'package:flutter/material.dart';
import 'package:jellywaves/utils/text.dart';

class ItemCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? imageUrl;
  final VoidCallback onTap;

  const ItemCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.imageUrl,
    required this.onTap
  });

  @override 
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          color: Color(0xff1A1A1A),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Color(0xffDDC6A7).withValues(alpha: 0.4),
            width: 0.5
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: imageUrl != null 
                  ? Image.network(
                      imageUrl!,
                      width: 80,
                      height: 80,
                      errorBuilder: (_, _, _) {
                        return _placeholder();
                      },
                    )
                  : _placeholder()
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 8, 10, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      appText(
                        text: title,
                        fontSize: 18,
                      ),
                      SizedBox(height: 3),
                      if (subtitle != null)
                        appText(
                          text: subtitle!,
                          color: Color(0xffDDC6A7).withValues(alpha: 0.6),
                          fontSize: 12
                        )
                    ],
                  )
                )
              )
            ],
          )
        )
      )
    );
  }

  Widget _placeholder() {
    return Container(
      width: 80,
      height: 80,
      color: Color(0xffDDC6A7),
      alignment: Alignment.center,
      child: Icon(
        Icons.album
      )
    );
  }
}
