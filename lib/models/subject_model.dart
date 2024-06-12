// lib/models/subject_model.dart
class Subject {
  final String name;
  final double progress;

  Subject({required this.name, required this.progress});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      name: json['name'],
      progress: (json['progress'] as num).toDouble(),
    );
  }
}
