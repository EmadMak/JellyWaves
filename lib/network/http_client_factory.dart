import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:cronet_http/cronet_http.dart';

Future<http.Client> buildHttpClient() async {
  if (Platform.isAndroid) {
    final engine = CronetEngine.build(
      cacheMode: CacheMode.memory,
      cacheMaxSize: 10 * 1024 * 1024,
      userAgent: "Jellywaves/0.1.0"
    );

    return CronetClient.fromCronetEngine(engine);
  }

  return IOClient(HttpClient());
}
