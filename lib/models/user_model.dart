// lib/models/user_model.dart
class User {
  final String username;
  final String email;
  final String profileImageUrl;
  final int grade;

  User({
    required this.username,
    required this.email,
    required this.profileImageUrl,
    required this.grade,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      email: json['email'],
      profileImageUrl: json['profile_image_url'],
      grade: json['grade'],
    );
  }
}
