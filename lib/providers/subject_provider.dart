// lib/providers/subject_provider.dart
import 'package:flutter/material.dart';
import 'package:somaa/models/subject_model.dart';
import 'package:somaa/services/api_service.dart';

class SubjectProvider with ChangeNotifier {
  List<Subject> _subjects = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Subject> get subjects => _subjects;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchSubjectsForGrade(int grade) async {
    _isLoading = true;
    notifyListeners();

    try {
      final fetchedSubjects = await ApiService().fetchSubjectsForGrade(grade);
      _subjects = fetchedSubjects;
      _errorMessage = '';
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
