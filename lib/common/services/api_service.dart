import 'package:flutter/foundation.dart';

// Simulate an API service
class ApiService {
  Future<bool> login(String username, String password) async {
    // Simulate an API call with a delay
    await Future.delayed(const Duration(seconds: 2));
    // In a real app, you'd make an actual API request here
    if (username == 'test' && password == 'password') {
      return true;
    } else {
      return false;
    }
  }
}