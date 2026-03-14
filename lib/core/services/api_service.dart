import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import '../config/app_config.dart';
import '../models/app_generation_session.dart';

class ApiService {
  final String _baseUrl = AppConfig.baseUrl;
  final Uuid _uuid = const Uuid();

  Future<Map<String, dynamic>> generateApp(String prompt) async {
    final requestId = _uuid.v4();
    final response = await http.post(
      Uri.parse('$_baseUrl/generate_app'),
      headers: {
        'Content-Type': 'application/json',
        'X-Request-ID': requestId,
      },
      body: jsonEncode({'prompt': prompt}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to generate app: ${response.body}');
    }
  }

  Future<AppGenerationSession> getBuildStatus(String sessionId) async {
    final response = await http.get(Uri.parse('$_baseUrl/build_status/$sessionId'));

    if (response.statusCode == 200) {
      return AppGenerationSession.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get build status');
    }
  }

  Future<List<String>> getLogs(String sessionId) async {
    final response = await http.get(Uri.parse('$_baseUrl/logs/$sessionId'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<String>.from(data['logs'] ?? []);
    } else {
      throw Exception('Failed to get logs');
    }
  }

  Future<List<AppGenerationSession>> getGeneratedApps() async {
    final response = await http.get(Uri.parse('$_baseUrl/generated_apps'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((json) => AppGenerationSession.fromJson(json)).toList();
    } else {
      throw Exception('Failed to get generated apps');
    }
  }
}
