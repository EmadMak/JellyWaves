import 'package:flutter/material.dart';
import 'package:jellywaves/models/album.dart';

class AlbumCard extends StatelessWidget {
  final Album album;
  final String imageUrl;
  final VoidCallback onTap;

  const AlbumCard({
    super.key,
    required this.album,
    required this.imageUrl,
    required this.onTap
  });

  @override 
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Color(0xff1A1A1A),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Color(0xffDDC6A7).withValues(alpha: 0.6),
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
                child: album.hasPrimaryImage 
                  ? Image.network(
                      imageUrl,
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
                      Text(
                        album.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Color(0xffDDC6A7),
                          fontSize: 18,
                        )
                      ),
                      SizedBox(height: 3),
                      Text(
                        [
                          if (album.artist != null) album.artist!,
                          if (album.year != null) album.year!
                        ].join(" • "),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Color(0xffDDC6A7).withValues(alpha: 0.6),
                          fontSize: 12
                        )
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
      width: double.infinity,
      color: Color(0xffDDC6A7),
      alignment: Alignment.center,
      child: Icon(
        Icons.album
      )
    );
  }
}
