import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:curves_pilates/features/authentication/presentation/provider/auth_provider.dart';
import 'package:curves_pilates/features/authentication/presentation/screens/login_screen.dart';
import 'package:curves_pilates/features/home/presentation/screens/home_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    // You can listen to the state or currentUser.
    // Using currentUser is often more direct for this purpose.
    if (authProvider.currentUser != null) {
      // If user is logged in (currentUser is not null), show HomeScreen
      return const HomeScreen();
    } else {
      // If user is not logged in, show LoginScreen
      return const LoginScreen();
    }

    /* Alternatively, you could use the AuthState:
    if (authProvider.state == AuthState.authenticated) {
      return const HomeScreen();
    } else {
      return const LoginScreen();
    }
    */
  }
}
