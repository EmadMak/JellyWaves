import 'package:flutter/material.dart';
import 'package:jellywaves/models/album.dart';
import 'package:jellywaves/services/jellyfin_api.dart';
import 'package:jellywaves/services/auth.dart';
import 'package:jellywaves/utils/cards.dart';

class AlbumsTab extends StatefulWidget {
  const AlbumsTab({super.key});

  @override 
  State<AlbumsTab> createState() => _AlbumsTabState();
}

class _AlbumsTabState extends State<AlbumsTab> {
  late final Future<_AlbumsData> _albumFuture;
  final authStorage = AuthStorage();

  @override 
  void initState() {
    super.initState();

    _albumFuture = _loadAlbums();
  }
  
  Future<_AlbumsData> _loadAlbums() async {
    final accessToken = await authStorage.getToken();
    final userId = await authStorage.getUserId();

    final albums = await JellyfinApi.instance.getItems<Album>(
      userId: userId!, 
      accessToken: accessToken!,
      itemType: "MusicAlbum",
      fields: 'PrimaryImageAspectRatio,ProductionYear,AlbumArtist',
      fromJson: Album.fromJson
    );
    
    return _AlbumsData(
      albums: albums,
      accessToken: accessToken
    );
  }

  @override 
  Widget build(BuildContext context) {
    return FutureBuilder<_AlbumsData>(
      future: _albumFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator()
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Could not load albums:\n${snapshot.error}",
              textAlign: TextAlign.center
            )
          );
        }

        final data = snapshot.data!;

        return ListView.separated(
          itemCount: data.albums.length,

          separatorBuilder: (context, index) {
            return SizedBox(height: 10);
          },

          itemBuilder: (context, index) {
            final album = data.albums[index];

            final imageUrl = JellyfinApi.instance.getImageUrl(
              accessToken: data.accessToken,
              id: album.id,
            ).toString();

            return ItemCard(
              title: album.name,
              subtitle: [
                if (album.artist != null) album.artist!,
                if (album.year != null) album.year
              ].join(" • "),
              imageUrl: imageUrl,
              onTap: () {}
            );
          }
        );
      }
    );
  }
}

class _AlbumsData {
  final List<Album> albums;
  final String accessToken;

  const _AlbumsData({
    required this.albums,
    required this.accessToken
  });
}
