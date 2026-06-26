import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jellywaves/network/http_client_factory.dart';
import 'package:jellywaves/models/login.dart';

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
  
  Future<List<T>> getItems<T>({
    required String accessToken,
    required String userId,
    required String itemType,
    required String fields,
    String endpoint = "Items",
    required T Function(Map<String, dynamic>) fromJson
  }) async {
    final uri = baseUrl.replace(
      path: '${baseUrl.path}/$endpoint',
      queryParameters: {
        "UserId": userId,
        'IncludeItemTypes': itemType,
        'Recursive': 'true',
        'SortBy': 'SortName',
        'SortOrder': 'Ascending',
        'Fields': fields
      }
    );

    final response = await client.get(
      uri,
      headers: {
        'Authorization': 
          'MediaBrowser Token="$accessToken"'
      }
    );

    if (response.statusCode != 200) {
      throw Exception(
        "could not load items: ${response.statusCode} ${response.body}"
      );
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;

    final items = data['Items'] as List<dynamic>;

    return items
      .map((item) => fromJson(item as Map<String, dynamic>))
      .toList(); 
  }

  Uri getImageUrl({
    required String accessToken,
    required String id
  }) {
    return baseUrl.replace(
      path: "${baseUrl.path}/Items/$id/Images/Primary",
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
