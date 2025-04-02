import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:developer' as developer;


class ApiClient {
  final String _baseUrl = 'https://theaudiodb.com/api/v1/json/';

  String get _apiKey => dotenv.env['THE_AUDIO_DB_API_KEY'] ?? '523532';

  Future<dynamic> get(String endpoint) async {
    final fullUrl = Uri.parse('$_baseUrl$_apiKey/$endpoint');
    developer.log('Making API request to: $fullUrl');
    
    try {
      final response = await http.get(fullUrl);
      developer.log('API Response status: ${response.statusCode}');
      developer.log('API Response body: ${response.body}');

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Erreur HTTP ${response.statusCode}');
      }
    } catch (e) {
      developer.log('API request error: $e');
      rethrow;
    }
  }
}
