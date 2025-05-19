import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final ApiService instance = ApiService._();
  ApiService._() {
    baseUrl = getBaseUrl();
  }

  static late String baseUrl;

  String getBaseUrl() {
    if (kIsWeb) {
      return 'localhost:8080';
    }
    return Platform.isAndroid ? '10.0.2.2:8080' : 'localhost:8080';
  }

  Future<String> get(
    String endpoint, {
    Map<String, dynamic> queryParams = const {},
  }) async {
    try {
      final url = Uri.http(baseUrl, endpoint, queryParams);
      final response = await http.get(url);
      if (response.statusCode != 200) {
        throw Exception('Failed to load data');
      }
      return response.body;
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to load data');
    }
  }
}
