class Album {
  final String id;
  final String name;
  final String? artist;
  final int? year;
  final bool hasPrimaryImage;

  const Album({
    required this.id,
    required this.name,
    this.artist,
    this.year,
    required this.hasPrimaryImage
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
