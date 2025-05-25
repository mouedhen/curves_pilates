import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../authentication/presentation/provider/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              // Call the logout method from AuthProvider
              Provider.of<AuthProvider>(context, listen: false).logout();
              // Optionally, navigate back to LoginScreen or show a confirmation
              // For this task, logout() will change AuthState, and main.dart's logic
              // should handle navigating back to LoginScreen.
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Text(
              'You are logged in as: ${Provider.of<AuthProvider>(context).currentUser?.username ?? 'Unknown User'}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Token: ${Provider.of<AuthProvider>(context).currentUser?.token ?? 'No Token'}',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
