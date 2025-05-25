import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter_foundations_01_task_manager_app/common/styling/app_colors.dart';
import 'package:flutter_foundations_01_task_manager_app/features/authentication/presentation/screens/login_screen.dart';
import 'package:flutter_foundations_01_task_manager_app/features/authentication/presentation/provider/auth_provider.dart';
import 'package:flutter_foundations_01_task_manager_app/features/authentication/domain/use_cases/login_use_case.dart';
import 'package:flutter_foundations_01_task_manager_app/features/authentication/data/repositories/auth_repository.dart';
import 'package:flutter_foundations_01_task_manager_app/common/services/api_service.dart';
import 'package:flutter_foundations_01_task_manager_app/common/widgets/loading_indicator.dart';
import 'package:mockito/mockito.dart'; // Required for mocking

// Mock classes
class MockApiService extends Mock implements ApiService {}
class MockAuthRepository extends Mock implements AuthRepository {}
class MockLoginUseCase extends Mock implements LoginUseCase {}

void main() {
  group('LoginScreen Tests', () {
    late ApiService mockApiService;
    late AuthRepository mockAuthRepository;
    late LoginUseCase mockLoginUseCase;
    late AuthProvider authProvider;

    setUp(() {
      // Setup mocks for each test
      mockApiService = MockApiService();
      mockAuthRepository = MockAuthRepository(mockApiService); // Assuming constructor takes ApiService
      mockLoginUseCase = MockLoginUseCase();
      authProvider = AuthProvider(mockLoginUseCase);
    });

    Future<void> pumpLoginScreen(WidgetTester tester, AuthProvider provider) async {
      await tester.pumpWidget(
        ChangeNotifierProvider<AuthProvider>.value(
          value: provider,
          child: const MaterialApp(home: LoginScreen()),
        ),
      );
    }

    testWidgets('renders header, input fields, and buttons with new styling', (WidgetTester tester) async {
      // Arrange
      // For this test, we don't need specific mock behavior for loginUseCase,
      // as we are just checking UI rendering in initial state.
      // However, ensure the provider is set up.
      when(mockLoginUseCase.execute(any<String>(), any<String>())).thenAnswer((_) async => null);


      await pumpLoginScreen(tester, authProvider);

      // Verification
      expect(find.text('Curves Pilates Club'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Adresse e-mail'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Mot de passe'), findsOneWidget);
      expect(find.byIcon(Icons.visibility_off), findsOneWidget); // Initial state of password icon
      expect(find.widgetWithText(TextButton, 'Mot de passe oublié'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'SE CONNECTER'), findsOneWidget);
      expect(find.text('OU'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'CRÉER UN COMPTE'), findsOneWidget);
    });

    testWidgets('password visibility toggle changes icon and obscurity', (WidgetTester tester) async {
      when(mockLoginUseCase.execute(any<String>(), any<String>())).thenAnswer((_) async => null);
      await pumpLoginScreen(tester, authProvider);

      // Verify initial state
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
      TextFormField passwordField = tester.widget<TextFormField>(find.widgetWithText(TextFormField, 'Mot de passe'));
      expect(passwordField.obscureText, isTrue);

      // Tap icon to make password visible
      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pump();

      expect(find.byIcon(Icons.visibility), findsOneWidget);
      passwordField = tester.widget<TextFormField>(find.widgetWithText(TextFormField, 'Mot de passe'));
      expect(passwordField.obscureText, isFalse);

      // Tap icon again to hide password
      await tester.tap(find.byIcon(Icons.visibility));
      await tester.pump();

      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
      passwordField = tester.widget<TextFormField>(find.widgetWithText(TextFormField, 'Mot de passe'));
      expect(passwordField.obscureText, isTrue);
    });

    testWidgets('shows LoadingIndicator when auth state is loading', (WidgetTester tester) async {
      // Mock LoginUseCase to delay
      when(mockLoginUseCase.execute(any<String>(), any<String>())).thenAnswer((_) async {
        await Future.delayed(const Duration(milliseconds: 100)); // Simulate network delay
        return null; // Simulate a login failure after delay
      });

      await pumpLoginScreen(tester, authProvider);

      // Trigger login
      authProvider.login("test@example.com", "password");
      await tester.pump(); // Pump once for AuthProvider to set state to loading

      // Verification
      expect(find.byType(LoadingIndicator), findsOneWidget);

      await tester.pumpAndSettle(); // Clean up any ongoing timers or animations
    });
  });
}
