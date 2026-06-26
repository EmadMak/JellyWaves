import 'package:flutter/material.dart';
import 'package:jellywaves/models/artist.dart';
import 'package:jellywaves/services/auth.dart';
import 'package:jellywaves/services/jellyfin_api.dart';
import 'package:jellywaves/utils/cards.dart';

class ArtistsTab extends StatefulWidget {
  const ArtistsTab({super.key});

  @override 
  State<ArtistsTab> createState() => _ArtistsTabState();
}

class _ArtistsTabState extends State<ArtistsTab> {
  late final Future<_ArtistsData> _artistsFuture;  
  final authStorage = AuthStorage(); 

  Future<_ArtistsData> _loadArtists() async {
    final accessToken = await authStorage.getToken();
    final userId = await authStorage.getUserId();

    final artists = await JellyfinApi.instance.getItems<Artist>(
      accessToken: accessToken!,
      userId: userId!,
      itemType: "MusicArtist",
      fields: "PrimaryImageAspectRatio",
      fromJson: Artist.fromJson
    );

    return _ArtistsData(
      artists: artists,
      accessToken: accessToken
    );
  }

  @override 
  void initState() {
    super.initState();

    _artistsFuture = _loadArtists();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_ArtistsData>(
      future: _artistsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator()
          ); 
        } 

        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Could not load Artists:\n${snapshot.error}",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white)
            )
          );
        }

        final data = snapshot.data!;

        return ListView.separated(
          itemCount: data.artists.length,
          separatorBuilder: (context, index) {
            return SizedBox(height: 10);
          },
          itemBuilder: (context, index) {
            final artist = data.artists[index];

            final imageUrl = JellyfinApi.instance.getImageUrl(
              accessToken: data.accessToken,
              id: artist.id
            ).toString();

            return ItemCard(
              title: artist.name,
              imageUrl: imageUrl,
              onTap: () {}
            ) ;
          }
       );
      }
    );
  }
}

class _ArtistsData {
  final List<Artist> artists;
  final String accessToken;

  _ArtistsData({
    required this.artists,
    required this.accessToken
  });
}
