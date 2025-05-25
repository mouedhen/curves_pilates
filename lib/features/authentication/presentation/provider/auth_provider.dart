import 'package:flutter/foundation.dart'; // For debugPrint
import 'package:flutter/material.dart';

import '../../domain/entities/user.dart'; // Import the User entity
import '../../domain/use_cases/login_use_case.dart';

enum AuthState { initial, loading, authenticated, error }

class AuthProvider extends ChangeNotifier {
  AuthState _state = AuthState.initial;
  AuthState get state => _state;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  User? _currentUser; // Add _currentUser field
  User? get currentUser => _currentUser; // Add getter for currentUser

  final LoginUseCase _loginUseCase;

  AuthProvider(this._loginUseCase);

  Future<void> login(String username, String password) async {
    _state = AuthState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final user = await _loginUseCase.execute(username, password);
      if (user != null) {
        _currentUser = user;
        _state = AuthState.authenticated;
        debugPrint('Login successful: ${user.username}, Token: ${user.token}');
      } else {
        _currentUser = null;
        _state = AuthState.error;
        _errorMessage = 'Invalid username or password.';
      }
    } on ArgumentError catch (e) {
      _currentUser = null;
      _state = AuthState.error;
      _errorMessage = e.message?.toString() ?? 'Invalid input.';
      debugPrint('Login ArgumentError: $e');
    } catch (e) {
      _currentUser = null;
      _state = AuthState.error;
      _errorMessage = 'An error occurred during login.';
      debugPrint('Login Error: $e');
    } finally {
      notifyListeners();
    }
  }

  void logout() {
    _state = AuthState.initial;
    _currentUser = null;
    _errorMessage = null;
    notifyListeners();
    // In a real app, you'd also clear any stored tokens from secure storage here.
  }
}
