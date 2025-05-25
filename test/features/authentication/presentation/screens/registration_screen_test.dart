import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter_foundations_01_task_manager_app/features/authentication/presentation/screens/registration_screen.dart';
import 'package:flutter_foundations_01_task_manager_app/features/authentication/presentation/screens/login_screen.dart';
import 'package:flutter_foundations_01_task_manager_app/features/authentication/presentation/provider/auth_provider.dart';
import 'package:flutter_foundations_01_task_manager_app/features/authentication/domain/use_cases/login_use_case.dart';
import 'package:flutter_foundations_01_task_manager_app/features/authentication/data/repositories/auth_repository.dart';
import 'package:flutter_foundations_01_task_manager_app/common/services/api_service.dart';

void main() {
  group('RegistrationScreen Tests', () {
    testWidgets('renders all required input fields, checkbox, and button', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: RegistrationScreen(),
        ),
      );

      // Verify the number of TextFormFields (Name, First Name, Birth Date, Phone, Address, Email, Password, Confirm Password)
      expect(find.byType(TextFormField), findsNWidgets(8));

      // Verify specific fields by their labelText.
      // Note: Using find.widgetWithText is a common way, but it requires the labelText to be directly a Text widget.
      // InputDecorations often have labelText as a property, so a more robust way might be needed if this fails,
      // such as finding by a common ancestor or by a predicate.
      expect(find.widgetWithText(TextFormField, 'Name'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'First Name'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Birth Date'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Phone Number'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Complete Address'), findsOneWidget);
      expect(find.widgetWithText(DropdownButtonFormField, 'Title'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Email Address'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Password'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Confirm Password'), findsOneWidget);

      // Verify CheckboxListTile and ElevatedButton
      expect(find.byType(CheckboxListTile), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Register'), findsOneWidget);
    });

    testWidgets('navigates from LoginScreen to RegistrationScreen', (WidgetTester tester) async {
      // Setup dependencies for LoginScreen and AuthProvider
      final ApiService apiService = ApiService();
      final AuthRepository authRepository = AuthRepository(apiService);
      final LoginUseCase loginUseCase = LoginUseCase(authRepository);
      final AuthProvider authProvider = AuthProvider(loginUseCase);

      await tester.pumpWidget(
        ChangeNotifierProvider<AuthProvider>.value(
          value: authProvider,
          child: const MaterialApp(
            home: LoginScreen(), // Start on LoginScreen
          ),
        ),
      );

      // Verify LoginScreen is present
      expect(find.byType(LoginScreen), findsOneWidget);

      // Find the "Create an account" button on LoginScreen
      final createAccountButtonFinder = find.widgetWithText(TextButton, 'Create an account');
      expect(createAccountButtonFinder, findsOneWidget);

      // Tap the button
      await tester.tap(createAccountButtonFinder);
      await tester.pumpAndSettle(); // Waits for animations and navigation to complete

      // Verify RegistrationScreen is now present and LoginScreen is not
      expect(find.byType(RegistrationScreen), findsOneWidget);
      expect(find.byType(LoginScreen), findsNothing);
    });
  });
}
