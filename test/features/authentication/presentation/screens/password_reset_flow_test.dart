import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:curves_pilates/features/authentication/presentation/screens/login_screen.dart';
import 'package:curves_pilates/features/authentication/presentation/screens/request_password_reset_screen.dart';
import 'package:curves_pilates/features/authentication/presentation/screens/enter_verification_code_screen.dart';
import 'package:curves_pilates/features/authentication/presentation/screens/reset_password_screen.dart'; // Import ResetPasswordScreen
import 'package:curves_pilates/features/authentication/presentation/provider/auth_provider.dart';
import 'package:curves_pilates/features/authentication/domain/use_cases/login_use_case.dart';
import 'package:curves_pilates/features/authentication/data/repositories/auth_repository.dart';
import 'package:curves_pilates/common/services/api_service.dart';

void main() {
  group('Password Reset Flow Tests', () {
    testWidgets('Full password reset navigation and basic UI rendering', (WidgetTester tester) async {
      // Test setup
      final ApiService apiService = ApiService();
      final AuthRepository authRepository = AuthRepository(apiService);
      final LoginUseCase loginUseCase = LoginUseCase(authRepository);
      final AuthProvider authProvider = AuthProvider(loginUseCase);

      await tester.pumpWidget(
        ChangeNotifierProvider<AuthProvider>.value(
          value: authProvider,
          child: const MaterialApp(
            home: LoginScreen(),
          ),
        ),
      );

      // Navigate to RequestPasswordResetScreen
      expect(find.byType(LoginScreen), findsOneWidget, reason: "LoginScreen should be present initially");
      await tester.tap(find.widgetWithText(TextButton, 'Mot de passe oublié')); // Updated finder text
      await tester.pumpAndSettle();

      expect(find.byType(RequestPasswordResetScreen), findsOneWidget, reason: "RequestPasswordResetScreen should be present after tap");
      
      // Verify AppBar Title (Optional but good)
      expect(find.descendant(of: find.byType(AppBar), matching: find.text('Réinitialisation du mot de passe')), findsOneWidget);
      
      // Verify Instruction Text
      expect(find.text('Entrez votre adresse e-mail pour recevoir les instructions de réinitialisation.'), findsOneWidget);
      
      // Verify Email Field Label and TextFormField
      expect(find.text('Adresse e-mail ou numéro de téléphone'), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget); // Assuming it's the only TextFormField visible

      // Verify Button Text
      expect(find.widgetWithText(ElevatedButton, 'Envoyer un lien de réinitialisation'), findsOneWidget, reason: "Send button should be on RequestPasswordResetScreen");

      // Verify Help Text
      expect(find.text('Si vous ne recevez pas d’e-mail, vérifiez votre dossier spam ou réessayez.'), findsOneWidget);

      // Navigate to EnterVerificationCodeScreen
      await tester.enterText(find.byType(TextFormField), 'test@example.com'); // Find by type, assuming it's the only one
      await tester.tap(find.widgetWithText(ElevatedButton, 'Envoyer un lien de réinitialisation'));
      await tester.pumpAndSettle();

      expect(find.byType(EnterVerificationCodeScreen), findsOneWidget, reason: "EnterVerificationCodeScreen should be present after sending code");
      expect(find.textContaining('test@example.com'), findsOneWidget, reason: "Email display should be on EnterVerificationCodeScreen");
      expect(find.widgetWithText(TextFormField, 'Verification Code'), findsOneWidget, reason: "Code field should be on EnterVerificationCodeScreen");
      expect(find.widgetWithText(ElevatedButton, 'Verify Code'), findsOneWidget, reason: "Verify button should be on EnterVerificationCodeScreen");
    });

    testWidgets('EnterVerificationCodeScreen code verification logic', (WidgetTester tester) async {
      // Test setup
      const String testEmail = 'user@example.com';
      const String correctCode = '123456'; // This is a fixed code for testing as Random is hard to mock directly in widget tests without more setup
                                          // In RequestPasswordResetScreen, the code is generated and printed. For this test, we assume a known code.

      await tester.pumpWidget(
        const MaterialApp(
          home: EnterVerificationCodeScreen(
            email: testEmail,
            verificationCode: correctCode, // Pass the "correct" code
          ),
        ),
      );

      // Test incorrect code
      await tester.enterText(find.widgetWithText(TextFormField, 'Verification Code'), '654321');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Verify Code'));
      await tester.pumpAndSettle(); // pumpAndSettle to allow SnackBar to appear and animations to finish
      expect(find.text('Invalid verification code. Please try again.'), findsOneWidget, reason: "Should show invalid code SnackBar");

      // Test correct code
      await tester.enterText(find.widgetWithText(TextFormField, 'Verification Code'), correctCode);
      await tester.tap(find.widgetWithText(ElevatedButton, 'Verify Code'));
      // This SnackBar is from EnterVerificationCodeScreen, before navigating to ResetPasswordScreen.
      // The navigation to ResetPasswordScreen is implicitly tested if the next screen's elements are found.
      // For this specific test, we are not verifying the SnackBar from EnterVerificationCodeScreen,
      // but rather the navigation. The original subtask updated EnterVerificationCodeScreen to navigate.
      // So, after the tap, we should be on ResetPasswordScreen.

      // If the previous test ('EnterVerificationCodeScreen code verification logic') was updated
      // to navigate to ResetPasswordScreen, this is how you'd continue that flow:
      // expect(find.byType(ResetPasswordScreen), findsOneWidget);
      // For now, this test correctly verifies EnterVerificationCodeScreen's own logic.
      // The full flow test verifies navigation up to EnterVerificationCodeScreen.
      // The new tests below will cover ResetPasswordScreen.
      // The SnackBar "Code Verified (Next step: New Password Screen - Not Implemented)" was removed
      // from EnterVerificationCodeScreen in a previous step and replaced with direct navigation.
      // So we expect to be on ResetPasswordScreen if we extended this test.
      // However, the task asks for *new* tests for ResetPasswordScreen.

      // The existing test is fine as it is for verifying EnterVerificationCodeScreen's output.
      // The navigation to ResetPasswordScreen is tested in the "Full password reset navigation"
      // if that test is extended OR if a new test starts from EnterVerificationCodeScreen and proceeds.

      // For clarity, the original "Code Verified..." SnackBar test line is removed as the screen now navigates.
      // If verification of navigation from EnterVerificationCodeScreen to ResetPasswordScreen is needed,
      // it should be part of the 'Full password reset navigation' or a dedicated test.
      // The current 'EnterVerificationCodeScreen code verification logic' test, after successful code,
      // would now navigate. Let's adjust the expectation for that.
      expect(find.byType(ResetPasswordScreen), findsOneWidget, reason: "Should navigate to ResetPasswordScreen after correct code");

    });

    testWidgets('ResetPasswordScreen UI elements and validation logic', (WidgetTester tester) async {
      const String testEmail = 'user@example.com';
      await tester.pumpWidget(
        MaterialApp(
          home: ResetPasswordScreen(email: testEmail),
        ),
      );

      // Verify UI Elements
      expect(find.widgetWithText(TextFormField, 'New Password'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Confirm New Password'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Change Password'), findsOneWidget);

      // Verification (Validation - Empty Fields)
      await tester.tap(find.widgetWithText(ElevatedButton, 'Change Password'));
      await tester.pump(); // Allow validation messages to appear
      expect(find.text('Please enter a new password'), findsOneWidget);
      expect(find.text('Please confirm your new password'), findsOneWidget);

      // Verification (Validation - Mismatch)
      await tester.enterText(find.widgetWithText(TextFormField, 'New Password'), 'password123');
      await tester.enterText(find.widgetWithText(TextFormField, 'Confirm New Password'), 'password456');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Change Password'));
      await tester.pump();
      expect(find.text('Passwords do not match'), findsOneWidget);
    });

    testWidgets('ResetPasswordScreen successful submission navigates to initial route', (WidgetTester tester) async {
      const String testEmail = 'user@example.com';

      await tester.pumpWidget(
        MaterialApp(
          home: const Scaffold(body: Text("Dummy Home")), // This acts as the initial route
        ),
      );
      
      // Manually push ResetPasswordScreen onto the stack
      // Need a context to push from, get it from the Dummy Home
      Navigator.of(tester.element(find.text("Dummy Home"))).push(MaterialPageRoute(
          builder: (_) => ResetPasswordScreen(email: testEmail)
      ));
      await tester.pumpAndSettle(); // Wait for ResetPasswordScreen to appear

      // Verify ResetPasswordScreen is present
      expect(find.byType(ResetPasswordScreen), findsOneWidget);

      // Enter matching passwords
      await tester.enterText(find.widgetWithText(TextFormField, 'New Password'), 'newSecurePassword');
      await tester.enterText(find.widgetWithText(TextFormField, 'Confirm New Password'), 'newSecurePassword');
      
      // Tap "Change Password"
      await tester.tap(find.widgetWithText(ElevatedButton, 'Change Password'));
      // Important: SnackBar display takes a moment, then navigation.
      // pump() for SnackBar, then pumpAndSettle() for navigation.
      await tester.pump(); // SnackBar appears
      expect(find.text('Password changed successfully!'), findsOneWidget);
      
      await tester.pumpAndSettle(); // Animation for SnackBar and navigation

      // Verify we are back on the "Dummy Home" (initial route)
      expect(find.text("Dummy Home"), findsOneWidget);
      expect(find.byType(ResetPasswordScreen), findsNothing);
    });
  });
}
