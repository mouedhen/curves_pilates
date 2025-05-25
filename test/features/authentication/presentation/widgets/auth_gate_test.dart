import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mockito/mockito.dart';
import 'package:curves_pilates/features/authentication/presentation/widgets/auth_gate.dart';
import 'package:curves_pilates/features/authentication/presentation/provider/auth_provider.dart';
import 'package:curves_pilates/features/authentication/presentation/screens/login_screen.dart';
import 'package:curves_pilates/features/home/presentation/screens/home_screen.dart';
import 'package:curves_pilates/features/authentication/domain/entities/user.dart';
// LoginUseCase is not directly used by AuthGate, so its mock is not needed here.

// Define MockAuthProvider if it's not centrally available
// For this task, we define it here.
class MockAuthProvider extends Mock implements AuthProvider {}

// Helper function for pumping AuthGate
Future<void> pumpAuthGate(WidgetTester tester, AuthProvider authProvider) {
  return tester.pumpWidget(
    ChangeNotifierProvider<AuthProvider>.value(
      value: authProvider,
      child: const MaterialApp(
        home: AuthGate(),
        // Ensure LoginScreen and HomeScreen don't cause issues by providing them with a mock provider if they also need it.
        // However, for testing AuthGate, we are checking for their *types*, not their full behavior.
        // If their internal structure requires a provider, this setup might need to be more complex
        // by wrapping them in their own providers or mocking their dependencies too.
        // For this specific test, we assume finding by type is sufficient.
      ),
    ),
  );
}

void main() {
  group('AuthGate Widget Tests', () {
    late MockAuthProvider mockAuthProvider;
    final tUser = User(id: '1', username: 'testuser', token: 'test_token');

    setUp(() {
      mockAuthProvider = MockAuthProvider();
      // It's crucial to stub the ChangeNotifier behavior if your widget relies on it.
      // For `currentUser`, it's a direct getter, but if you were listening to `state`
      // and `notifyListeners` was called, you'd need to handle that.
      // Here, AuthGate rebuilds when Provider.of<AuthProvider>(context) changes.
    });

    testWidgets('Shows LoginScreen when user is null (logged out)', (WidgetTester tester) async {
      // Stubbing
      when(mockAuthProvider.currentUser).thenReturn(null);
      // If AuthGate also listens to `state` for example:
      // when(mockAuthProvider.state).thenReturn(AuthState.initial);

      // Execution
      await pumpAuthGate(tester, mockAuthProvider);
      await tester.pump(); // Ensure widget tree settles

      // Verification
      expect(find.byType(LoginScreen), findsOneWidget);
      expect(find.byType(HomeScreen), findsNothing);
    });

    testWidgets('Shows HomeScreen when user is not null (logged in)', (WidgetTester tester) async {
      // Stubbing
      when(mockAuthProvider.currentUser).thenReturn(tUser);
      // If AuthGate also listens to `state`:
      // when(mockAuthProvider.state).thenReturn(AuthState.authenticated);

      // Execution
      await pumpAuthGate(tester, mockAuthProvider);
      await tester.pump(); // Ensure widget tree settles

      // Verification
      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(LoginScreen), findsNothing);
    });

    testWidgets('Switches from HomeScreen to LoginScreen on simulated logout', (WidgetTester tester) async {
      // Setup (Logged In)
      when(mockAuthProvider.currentUser).thenReturn(tUser);
      await pumpAuthGate(tester, mockAuthProvider);
      await tester.pump();
      expect(find.byType(HomeScreen), findsOneWidget, reason: "Should initially show HomeScreen");

      // Simulate Logout (update mock and re-pump)
      when(mockAuthProvider.currentUser).thenReturn(null);
      // If AuthGate also uses `state` for its logic:
      // when(mockAuthProvider.state).thenReturn(AuthState.initial);

      // Re-pump with the same provider instance whose mocked behavior has changed.
      // The ChangeNotifierProvider.value should detect the "change" or rather,
      // when AuthGate rebuilds, it will call the mock again and get the new value.
      await tester.pump(); // Allow AuthGate to rebuild

      // Verification
      expect(find.byType(LoginScreen), findsOneWidget, reason: "Should show LoginScreen after logout");
      expect(find.byType(HomeScreen), findsNothing, reason: "Should not show HomeScreen after logout");
    });
  });
}
