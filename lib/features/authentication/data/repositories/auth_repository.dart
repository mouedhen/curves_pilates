import '../../../../common/services/api_service.dart';

class AuthRepository {
  final ApiService _apiService;

  AuthRepository(this._apiService);

  Future<bool> login(String username, String password) async {
    return _apiService.login(username, password);
  }
}