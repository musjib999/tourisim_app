import 'dart:convert';

import 'package:flutter/services.dart';

Future readJson(String jsonFilePath) async {
  final String response = await rootBundle.loadString(jsonFilePath);
  final data = await json.decode(response);
  return data;
}
