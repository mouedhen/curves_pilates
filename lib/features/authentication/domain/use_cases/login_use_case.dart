import '../../data/repositories/auth_repository.dart';
import '../entities/user.dart'; // Could have a User entity

class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  Future<bool> execute(String username, String password) async {
    // You could add more business logic here before calling the repository
    return _authRepository.login(username, password);
  }
}