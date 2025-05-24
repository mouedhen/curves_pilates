import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_foundations_01_task_manager_app/features/authentication/presentation/provider/auth_provider.dart';
import 'package:flutter_foundations_01_task_manager_app/features/authentication/domain/use_cases/login_use_case.dart';
import 'package:flutter_foundations_01_task_manager_app/features/authentication/domain/entities/user.dart';
import 'package:flutter/material.dart'; // Required for ChangeNotifier

// Create a mock for LoginUseCase
class MockLoginUseCase extends Mock implements LoginUseCase {}

void main() {
  group('AuthProvider', () {
    late AuthProvider authProvider;
    late MockLoginUseCase mockLoginUseCase;
    late User tUser;

    setUp(() {
      mockLoginUseCase = MockLoginUseCase();
      authProvider = AuthProvider(mockLoginUseCase);
      tUser = User(id: '1', username: 'testuser', token: 'test_token');
    });

    test('initial state is correct', () {
      expect(authProvider.state, AuthState.initial);
      expect(authProvider.currentUser, null);
      expect(authProvider.errorMessage, null);
    });

    test('login successful should update state and currentUser', () async {
      // Arrange
      when(mockLoginUseCase.execute(any, any)).thenAnswer((_) async => tUser);
      
      // Act
      final future = authProvider.login('testuser', 'password');
      
      // Assert immediately for loading state
      expect(authProvider.state, AuthState.loading);
      
      await future; // Wait for the login process to complete
      
      expect(authProvider.state, AuthState.authenticated);
      expect(authProvider.currentUser, tUser);
      expect(authProvider.errorMessage, null);
      verify(mockLoginUseCase.execute('testuser', 'password')).called(1);
      verifyNoMoreInteractions(mockLoginUseCase);
    });

    test('login failed (use case returns null) should update state and errorMessage', () async {
      // Arrange
      when(mockLoginUseCase.execute(any, any)).thenAnswer((_) async => null);

      // Act
      final future = authProvider.login('testuser', 'wrongpassword');
      expect(authProvider.state, AuthState.loading); // Check loading state
      await future;

      // Assert
      expect(authProvider.state, AuthState.error);
      expect(authProvider.currentUser, null);
      expect(authProvider.errorMessage, 'Invalid username or password.');
      verify(mockLoginUseCase.execute('testuser', 'wrongpassword')).called(1);
      verifyNoMoreInteractions(mockLoginUseCase);
    });

    test('login throws exception should update state and errorMessage', () async {
      // Arrange
      when(mockLoginUseCase.execute(any, any)).thenThrow(Exception('Network error'));

      // Act
      final future = authProvider.login('testuser', 'password');
      expect(authProvider.state, AuthState.loading); // Check loading state
      await future;

      // Assert
      expect(authProvider.state, AuthState.error);
      expect(authProvider.currentUser, null);
      expect(authProvider.errorMessage, 'An error occurred during login.');
      verify(mockLoginUseCase.execute('testuser', 'password')).called(1);
      verifyNoMoreInteractions(mockLoginUseCase);
    });

    test('logout should reset state and currentUser', () async {
      // Arrange: Simulate a logged-in state first
      when(mockLoginUseCase.execute('testuser', 'password')).thenAnswer((_) async => tUser);
      await authProvider.login('testuser', 'password');
      
      // Pre-check to ensure login was successful
      expect(authProvider.state, AuthState.authenticated);
      expect(authProvider.currentUser, tUser);

      // Act
      authProvider.logout();

      // Assert
      expect(authProvider.state, AuthState.initial);
      expect(authProvider.currentUser, null);
      expect(authProvider.errorMessage, null); // Ensure error message is also cleared
      // verifyNoMoreInteractions(mockLoginUseCase); // Not strictly needed here as logout doesn't call usecase
    });
  });
}
