// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:somaa/config.dart';
import 'package:somaa/models/subject_model.dart';
import 'package:somaa/models/user_model.dart';
// import 'package:system_auth/config.dart';
// import 'package:system_auth/models/user_model.dart';
// import 'package:system_auth/models/subject_model.dart';

class ApiService {
  final String baseUrl = Config.backendUrl;

  Future<User> fetchUserProfile() async {
    final response = await http.get(Uri.parse('$baseUrl/profile'));

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch user profile');
    }
  }

  Future<User> updateUserProfile(String username, int grade) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'grade': grade}),
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update user profile');
    }
  }

  Future<List<Subject>> fetchSubjectsForGrade(int grade) async {
    final response = await http.get(Uri.parse('$baseUrl/subjects?grade=$grade'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((subject) => Subject.fromJson(subject)).toList();
    } else {
      throw Exception('Failed to fetch subjects');
    }
  }
}
