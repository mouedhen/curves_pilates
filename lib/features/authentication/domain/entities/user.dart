// lib/features/authentication/domain/entities/user.dart

class User {
  final String id;
  final String username;
  final String? email; // Email is optional in this example
  final String? displayName;
  final DateTime? registrationDate;
  final String? token;

  User({
    required this.id,
    required this.username,
    this.email,
    this.displayName,
    this.registrationDate,
    this.token,
  });

  // Optional: Add methods for comparing users
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          username == other.username &&
          email == other.email &&
          displayName == other.displayName &&
          registrationDate == other.registrationDate &&
          token == other.token;

  @override
  int get hashCode =>
      id.hashCode ^
      username.hashCode ^
      email.hashCode ^
      displayName.hashCode ^
      registrationDate.hashCode ^
      token.hashCode;

  // Optional: Add a method to create a User from a JSON object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String?,
      displayName: json['display_name'] as String?,
      registrationDate: json['registration_date'] != null
          ? DateTime.parse(json['registration_date'] as String)
          : null,
      token: json['token'] as String?,
    );
  }

  // Optional: Add a method to convert a User to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'display_name': displayName,
      'registration_date': registrationDate?.toIso8601String(),
      'token': token,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, username: $username, email: $email, displayName: $displayName, registrationDate: $registrationDate, token: $token}';
  }
}