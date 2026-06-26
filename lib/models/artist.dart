class Artist {
  final String id;
  final String name;
  final bool hasPrimaryImage;
  
  Artist({
    required this.id,
    required this.name,
    required this.hasPrimaryImage
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json["Id"] as String,
      name: json["Name"] as String,
      hasPrimaryImage: json["ImageTags"]["Primary"] != null
    );
  }
}
