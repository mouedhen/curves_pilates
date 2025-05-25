import '../../../../../common/services/api_service.dart';
import '../../domain/entities/user.dart';

class AuthRepository {
  final ApiService _apiService;

  AuthRepository(this._apiService);

  Future<User?> login(String username, String password) async {
    // Call the ApiService's login method, which now returns a User?
    final user = await _apiService.login(username, password);
    return user;
  }
}