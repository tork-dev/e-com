import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;

class AppHttpHelper {
  static const String _baseUrl = 'https://app.kireibd.com/api/v2'; // Replace with your API base URL

  // Helper method to make a GET request
  static Future<Map<String, dynamic>> get(String endpoint, modelClass) async {
    final response = await http.get(Uri.parse('$_baseUrl/$endpoint'));
    return _handleResponse(response, modelClass);
  }

  // Helper method to make a POST request
  static Future<Map<String, dynamic>> post(String endpoint, dynamic data, modelClass) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {
        "Accept": "*/*",
        'Content-Type': 'application/json'
      },
      body: json.encode(data),
    );
    return _handleResponse(response, modelClass);
  }

  // Helper method to make a PUT request
  static Future<Map<String, dynamic>> put(String endpoint, dynamic data, modelClass) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response, modelClass);
  }

  // Helper method to make a DELETE request
  static Future<Map<String, dynamic>> delete(String endpoint, modelClass) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$endpoint'));
    return _handleResponse(response, modelClass);
  }

  // Handle the HTTP response
  static Map<String, dynamic> _handleResponse(http.Response response, modelClass) {
    if (response.statusCode == 200) {
      var responseBody = response.body;
      return modelClass(responseBody);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
