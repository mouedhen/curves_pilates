import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/widgets/loading_indicator.dart';
// import '../../../../features/home/presentation/screens/home_screen.dart'; // No longer needed here
import '../provider/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.login(
      _usernameController.text.trim(),
      _passwordController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          if (authProvider.state == AuthState.loading) {
            return const LoadingIndicator();
          }

          // Clear password field on error
          if (authProvider.state == AuthState.error) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _passwordController.clear();
            });
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => _login(context),
                  child: const Text('Login'),
                ),
                if (authProvider.state == AuthState.error &&
                    authProvider.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      authProvider.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                // Removed the direct "Login Successful!" message here
              ],
            ),
          );
        },
      ),
    );
  }

  // Removed didChangeDependencies method as AuthGate now handles navigation
}