import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:curves_pilates/features/authentication/presentation/screens/registration_screen.dart';
import 'package:curves_pilates/features/authentication/presentation/screens/login_screen.dart';
import 'package:curves_pilates/features/authentication/presentation/provider/auth_provider.dart';
import 'package:curves_pilates/features/authentication/domain/use_cases/login_use_case.dart';
import 'package:curves_pilates/features/authentication/data/repositories/auth_repository.dart';
import 'package:curves_pilates/common/services/api_service.dart';

void main() {
  group('RegistrationScreen Tests', () {
    testWidgets('renders all required input fields, checkbox, and button', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: RegistrationScreen(),
        ),
      );

      // Verify labels
      expect(find.text('Nom'), findsOneWidget);
      expect(find.text('Prénom'), findsOneWidget);
      expect(find.text('Date de naissance'), findsOneWidget);
      expect(find.text('Numéro de téléphone'), findsOneWidget);
      expect(find.text('Adresse complète'), findsOneWidget);
      expect(find.text('Titre'), findsOneWidget); // Label for dropdown
      expect(find.text('Adresse e-mail'), findsOneWidget);
      expect(find.text('Mot de passe'), findsOneWidget);
      expect(find.text('Confirmer le mot de passe'), findsOneWidget);

      // Verify Input Widget Types and Count
      expect(find.byType(TextFormField), findsNWidgets(8));
      expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);

      // Verify Checkbox
      expect(find.widgetWithText(CheckboxListTile, "J'accepte les conditions d'utilisation de Curves"), findsOneWidget);

      // Verify Button
      expect(find.widgetWithText(ElevatedButton, 'CONTINUER'), findsOneWidget);

      // Verify Password Visibility Icons
      expect(find.byIcon(Icons.visibility_off), findsNWidgets(2));
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
      final createAccountButtonFinder = find.widgetWithText(ElevatedButton, 'CRÉER UN COMPTE'); // Updated finder
      expect(createAccountButtonFinder, findsOneWidget);

      // Tap the button
      await tester.tap(createAccountButtonFinder);
      await tester.pumpAndSettle(); // Waits for animations and navigation to complete

      // Verify RegistrationScreen is now present and LoginScreen is not
      expect(find.byType(RegistrationScreen), findsOneWidget);
      expect(find.byType(LoginScreen), findsNothing);
    });

    testWidgets('Titre dropdown shows correct French options', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: RegistrationScreen(),
        ),
      );

      // Tap the "Titre" DropdownButtonFormField to open the items.
      // We find the DropdownButtonFormField itself first.
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle(); // Wait for the dropdown items to appear

      // Verify each option is present. Using .last because the label 'Titre' might also be found by find.text.
      expect(find.text('Madame').last, findsOneWidget);
      expect(find.text('Mademoiselle').last, findsOneWidget);
      expect(find.text('Monsieur').last, findsOneWidget);
    });
  });
}
