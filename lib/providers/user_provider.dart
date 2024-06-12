// lib/providers/user_provider.dart
import 'package:flutter/material.dart';
import 'package:somaa/models/user_model.dart';
import 'package:somaa/services/api_service.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  String _errorMessage = '';

  User? get user => _user;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchUserData() async {
    _isLoading = true;
    notifyListeners();

    try {
      final fetchedUser = await ApiService().fetchUserProfile();
      _user = fetchedUser;
      _errorMessage = '';
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateUserProfile(String username, int grade) async {
    _isLoading = true;
    notifyListeners();

    try {
      final updatedUser = await ApiService().updateUserProfile(username, grade);
      _user = updatedUser;
      _errorMessage = '';
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
