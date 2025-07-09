import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

Future<Map<String, dynamic>> jsonToMap(String json) async {
  final data = await compute(jsonDecode, json);

  return (data as Map).cast();
}

Future<List<dynamic>> jsonToList(String json) async {
  final data = await compute(jsonDecode, json);
  return data as List;
}
