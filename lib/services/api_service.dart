import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static final ApiService instance = ApiService._();
  ApiService._() {
    baseUrl = getBaseUrl();
  }

  static late String baseUrl;

  getBaseUrl() {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8080';
    }
    return 'http://localhost:8080';
  }

  Future<http.Response> get(String endpoint) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    final response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode != 200) {
      throw Exception('Failed to load data');
    }
    return response;
  }
}
