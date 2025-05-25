import 'package:curves_pilates/features/authentication/domain/entities/user.dart';

class ApiService {
  Future<User?> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    if (username == 'test' && password == 'password') {
      return User(
        id: '123',
        username: username,
        token: 'fake_jwt_token', // Dummy token
      );
    } else {
      return null;
    }
  }
}
