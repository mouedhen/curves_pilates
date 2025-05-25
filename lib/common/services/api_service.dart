import 'package:flutter/foundation.dart';
import 'package:flutter_foundations_01_task_manager_app/features/authentication/domain/entities/user.dart';

// Simulate an API service
class ApiService {
  Future<User?> login(String username, String password) async {
    // Simulate an API call with a delay
    await Future.delayed(const Duration(seconds: 2));
    // In a real app, you'd make an actual API request here
    if (username == 'test' && password == 'password') {
      // Simulate a successful login
      return User(
        id: '123', // Simulated user ID
        username: username,
        token: 'fake_jwt_token', // Dummy token
        // You can add other user details here if needed
      );
    } else {
      // Simulate a failed login
      return null;
    }
  }
}