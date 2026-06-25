import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jellywaves/network/http_client_factory.dart';
import 'package:jellywaves/models/login.dart';
import 'package:jellywaves/models/album.dart';

class JellyfinApi{
  JellyfinApi._({
    required String baseUrl,
    required this.client
  }) : baseUrl = Uri.parse(baseUrl);

  static JellyfinApi? _instance;

  static JellyfinApi get instance{
    if (_instance == null ) {
      throw StateError(
        "JellyfinApi has not been initialized yet"
      );
    }

    return _instance!;
  }

  static Future<void> initialize({
    required String baseUrl 
  }) async {
    final client = await buildHttpClient();

    _instance = JellyfinApi._(
      client: client,
      baseUrl: baseUrl
    );
  } 

  final Uri baseUrl;
  final http.Client client;

  Future<Map<String, dynamic>> systemInfo() async {
    final response = await client.get(
      baseUrl.resolve('/System/Info/Public'),
    );

    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  Future<LoginResult> login({
    required String username,
    required String password
  }) async {
    final response = await client.post(
      baseUrl.resolve("/Users/authenticatebyname"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'MediaBrowser Client="Jellywaves", Device="Android", DeviceId="jellywaves-dev-001", Version="0.1.0"',
      },
      body: jsonEncode({
        'Username': username,
        "Pw": password
      })
    );

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    return LoginResult.fromJson(data);
  }
  
  Future<void> logout (String accessToken) async {
    final response = await client.post(
      baseUrl.resolve("/Sessions/Logout"),
      headers: {
        'Authorization':
            'MediaBrowser Client="Jellywaves", Device="Android", DeviceId="jellywaves-dev-001", Version="0.1.0", Token="$accessToken"',
      }
    );
    
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        "Logout failed: ${response.statusCode} ${response.body}"
      );
    }
  }
  
  Future<List<Album>> getAlbums({
    required String accessToken,
    required String userId
  }) async {
    final uri = baseUrl.replace(
      path: '${baseUrl.path}/Items',
      queryParameters: {
        'UserId': userId,
        'IncludeItemTypes': 'MusicAlbum',
        'Recursive': 'true',
        'SortBy': 'SortName',
        'SortOrder': 'Ascending',
        'Fields': 'PrimaryImageAspectRatio,ProductionYear,AlbumArtist'
      }
    );

    final response = await client.get(
      uri,
      headers: {
        'Authorization': 
          'MediaBrowser Token="$accessToken'
      }
    );

    if (response.statusCode != 200) {
      throw Exception(
        "could not load albums: ${response.statusCode} ${response.body}"
      );
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;

    final items = data['Items'] as List<dynamic>;

    return items
      .map((item) => Album.fromJson(item as Map<String, dynamic>))
      .toList(); 
  }

  Uri getAlbumImageUrl({
    required String accessToken,
    required String albumId
  }) {
    return baseUrl.replace(
      path: "${baseUrl.path}/Items/$albumId/Images/Primary",
      queryParameters: {
        'maxWidth': '320',
        'quality': '90'
      }
    );
  }

  static void dispose() {
    _instance?.client.close();
    _instance = null;
  }
}
