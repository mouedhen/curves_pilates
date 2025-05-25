import 'dart:async';

import '../../data/repositories/auth_repository.dart';
import '../entities/user.dart';

class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  FutureOr<User?> execute(String username, String password) {
    final trimmedUsername = username.trim();
    final trimmedPassword = password.trim();
    if (trimmedUsername.isEmpty || trimmedPassword.isEmpty) {
      throw ArgumentError('Username and password must not be empty.');
    }
    return _authRepository.login(trimmedUsername, trimmedPassword);
  }
}