import 'dart:convert';
import 'package:http/http.dart' as http;

class JellyfinApi{
  final Uri baseUrl;
  final http.Client client;

  JellyfinApi({
    required String baseUrl,
    required this.client,
  }) : baseUrl = Uri.parse(baseUrl);

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
    final response = await http.post(
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
}
