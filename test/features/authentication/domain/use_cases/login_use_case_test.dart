import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:curves_pilates/features/authentication/domain/use_cases/login_use_case.dart';
import 'package:curves_pilates/features/authentication/data/repositories/auth_repository.dart';
import 'package:curves_pilates/features/authentication/domain/entities/user.dart';

// Create a mock for AuthRepository using Mockito
class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group('LoginUseCase', () {
    late LoginUseCase loginUseCase;
    late MockAuthRepository mockAuthRepository;

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      loginUseCase = LoginUseCase(mockAuthRepository);
    });

    final tUser = User(id: '1', username: 'testuser', token: 'test_token');
    const tUsername = 'testuser';
    const tPassword = 'password';
    const tWrongUsername = 'wronguser';
    const tWrongPassword = 'wrongpass';

    test('should return User when login is successful', () async {
      // Stubbing: Use when(mockAuthRepository.login(any, any)).thenAnswer((_) async => tUser);
      when(mockAuthRepository.login(any, any)).thenAnswer((_) async => tUser);

      // Execution: Call loginUseCase.execute('testuser', 'password')
      final result = await loginUseCase.execute(tUsername, tPassword);

      // Verification:
      // Expect the result to be the tUser
      expect(result, tUser);
      // Verify mockAuthRepository.login('testuser', 'password') was called once
      verify(mockAuthRepository.login(tUsername, tPassword)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should return null when login fails (repository returns null)', () async {
      // Stubbing: when(mockAuthRepository.login(any, any)).thenAnswer((_) async => null);
      when(mockAuthRepository.login(any, any)).thenAnswer((_) async => null);

      // Execution: Call loginUseCase.execute('wronguser', 'wrongpass')
      final result = await loginUseCase.execute(tWrongUsername, tWrongPassword);

      // Verification:
      // Expect the result to be null
      expect(result, null);
      // Verify mockAuthRepository.login('wronguser', 'wrongpass') was called once
      verify(mockAuthRepository.login(tWrongUsername, tWrongPassword)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });
  });
}
