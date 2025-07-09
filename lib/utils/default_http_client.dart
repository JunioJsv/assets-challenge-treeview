import 'dart:io';

import 'package:assets_challenge/utils/ihttp_client.dart';
import 'dart:convert';

class DefaultHttpClient extends IHttpClient {
  final _client = HttpClient();
  @override
  Future<String> get(String url) async {
    final request = await _client.getUrl(Uri.parse(url));
    final response = await request.close();
    return await response.transform(utf8.decoder).join();
  }
}