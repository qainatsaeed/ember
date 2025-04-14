// models/user.dart
class User {
  User({required this.id, required this.username, required this.email});

  // Factory method
  factory User.fromMap(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
    );
  }
  final String id;
  final String username;
  final String email;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
    };
  }
}
