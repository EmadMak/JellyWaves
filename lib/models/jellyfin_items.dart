abstract class JellyfinItem {
  String get id;
  String get name;
  bool get hasPrimaryImage; 
}

class Genre implements JellyfinItem {
  @override
  final String id;

  @override 
  final String name;

  @override 
  final bool hasPrimaryImage;

  const Genre({
    required this.id,
    required this.name,
    required this.hasPrimaryImage
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json["Id"],
      name: json["Name"],
      hasPrimaryImage: json["ImageTags"]["Primary"] != null
    );
  }
}

class Album implements JellyfinItem {
  @override 
  final String id;

  @override 
  final String name;
  
  @override
  final bool hasPrimaryImage;

  final String? artist;
  final int? year;

  const Album({
    required this.id,
    required this.name,
    required this.hasPrimaryImage,
    this.artist,
    this.year
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['Id'] as String,
      name: json['Name'] as String,
      artist: json['AlbumArtist'] as String?,
      year: json['ProductionYear'] as int?,
      hasPrimaryImage: json["ImageTags"]["Primary"] != null
    );
  }
}

class Artist implements JellyfinItem {
  @override 
  final String id;

  @override 
  final String name;

  @override 
  final bool hasPrimaryImage;

  const Artist({
    required this.id,
    required this.name,
    required this.hasPrimaryImage 
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json["Id"],
      name: json["Name"],
      hasPrimaryImage: json["ImageTags"]["Primary"] != null
    );
  }
}

class Song implements JellyfinItem {
  @override 
  final String id;

  @override 
  final String name;

  @override 
  final bool hasPrimaryImage;

  final String? albumId;

  const Song({
    required this.id,
    required this.name,
    required this.hasPrimaryImage,
    this.albumId
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json["Id"],
      name: json["Name"],
      albumId: json["AlbumId"],
      hasPrimaryImage: json["ImageTags"]?["Primary"] != null
    );
  }
}


class Playlist implements JellyfinItem {
  @override 
  final String id;

  @override 
  final String name;

  @override 
  final bool hasPrimaryImage;

  const Playlist({
    required this.id,
    required this.name,
    required this.hasPrimaryImage 
  });

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      id: json["Id"],
      name: json["Name"],
      hasPrimaryImage: json["ImageTags"]["Primary"] != null
    );
  }
}
