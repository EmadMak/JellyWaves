import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jellywaves/network/http_client_factory.dart';

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

  Future<String> login({
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
    return data['AccessToken'] as String;
  }
  
  Future<void> logout (String token) async {
    final response = await client.post(
      baseUrl.resolve("/Sessions/Logout"),
      headers: {
        'Authorization':
            'MediaBrowser Client="Jellywaves", Device="Android", DeviceId="jellywaves-dev-001", Version="0.1.0", Token="$token"',
      }
    );
    
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        "Logout failed: ${response.statusCode} ${response.body}"
      );
    }
  }

  static void dispose() {
    _instance?.client.close();
    _instance = null;
  }
}
