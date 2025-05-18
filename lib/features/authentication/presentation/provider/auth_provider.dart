import 'package:flutter/material.dart';
import '../../domain/use_cases/login_use_case.dart';

enum AuthState { initial, loading, authenticated, error }

class AuthProvider extends ChangeNotifier {
  AuthState _state = AuthState.initial;
  AuthState get state => _state;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  final LoginUseCase _loginUseCase;

  AuthProvider(this._loginUseCase);

  Future<void> login(String username, String password) async {
    _state = AuthState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final success = await _loginUseCase.execute(username, password);
      if (success) {
        _state = AuthState.authenticated;
      } else {
        _state = AuthState.error;
        _errorMessage = 'Invalid username or password.';
      }
    } catch (e) {
      _state = AuthState.error;
      _errorMessage = 'An error occurred during login.';
      debugPrint('Login Error: $e');
    } finally {
      notifyListeners();
    }
  }

  void logout() {
    _state = AuthState.initial;
    notifyListeners();
    // In a real app, you'd clear tokens, etc.
  }
}