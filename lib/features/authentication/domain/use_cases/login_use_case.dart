import 'package:curves_pilates/features/authentication/data/repositories/auth_repository.dart';
import 'package:curves_pilates/features/authentication/domain/entities/user.dart';

class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  Future<User?> execute(String username, String password) async {
    // You could add more business logic here before calling the repository
    // For example, input validation, logging, etc.
    final user = await _authRepository.login(username, password);
    return user;
  }
}