import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:curves_pilates/features/authentication/presentation/screens/login_screen.dart';
import 'package:curves_pilates/features/authentication/presentation/screens/request_password_reset_screen.dart';
import 'package:curves_pilates/features/authentication/presentation/screens/enter_verification_code_screen.dart';
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
      await tester.tap(find.widgetWithText(TextButton, 'Forgot password?'));
      await tester.pumpAndSettle();

      expect(find.byType(RequestPasswordResetScreen), findsOneWidget, reason: "RequestPasswordResetScreen should be present after tap");
      expect(find.widgetWithText(TextFormField, 'Email Address'), findsOneWidget, reason: "Email field should be on RequestPasswordResetScreen");
      expect(find.widgetWithText(ElevatedButton, 'Send Verification Code'), findsOneWidget, reason: "Send button should be on RequestPasswordResetScreen");

      // Navigate to EnterVerificationCodeScreen
      await tester.enterText(find.widgetWithText(TextFormField, 'Email Address'), 'test@example.com');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Send Verification Code'));
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
      await tester.pumpAndSettle();
      expect(find.text('Code Verified (Next step: New Password Screen - Not Implemented)'), findsOneWidget, reason: "Should show code verified SnackBar");
    });
  });
}
