// lib/providers/auth_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthProvider with ChangeNotifier {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> saveSessionCookie(String cookie) async {
    await _storage.write(key: 'session_cookie', value: cookie);
  }

  Future<String?> getSessionCookie() async {
    return await _storage.read(key: 'session_cookie');
  }

  Future<void> clearSession() async {
    await _storage.deleteAll();
  }
}
