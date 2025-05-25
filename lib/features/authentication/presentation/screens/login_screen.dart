import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/styling/app_colors.dart'; // Import AppColors
import '../../../../common/widgets/loading_indicator.dart';
import '../provider/auth_provider.dart';
import './registration_screen.dart';
import './request_password_reset_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordHidden = true; // Added state variable

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
      backgroundColor: AppColors.beigeBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0), // Overall padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              // To make buttons full width later
              children: <Widget>[
                // Header
                const Text(
                  'Curves Pilates Club',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBrownText,
                  ),
                ),
                const SizedBox(height: 40.0),
                // Spacing after header

                // Consumer for the rest of the content that depends on AuthProvider
                Consumer<AuthProvider>(
                  builder: (context, authProvider, _) {
                    if (authProvider.state == AuthState.loading) {
                      return const Center(child: LoadingIndicator());
                    }

                    // Logic to clear password on error
                    if (authProvider.state == AuthState.error) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _passwordController.clear();
                      });
                    }

                    // Return the Column containing the form elements
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          // Changed from TextField
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Adresse e-mail',
                            labelStyle: const TextStyle(
                              color: AppColors.darkBrownText,
                              fontSize: 16.0,
                            ),
                            filled: true,
                            fillColor: AppColors.inputBoxBrown,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                color: AppColors.darkBrownText,
                                width: 1.0,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 12.0,
                            ),
                          ),
                          style: const TextStyle(
                            color: AppColors.darkBrownText,
                            fontSize: 16.0,
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          // Changed from TextField
                          controller: _passwordController,
                          obscureText: _isPasswordHidden,
                          // Bind to state variable
                          decoration: InputDecoration(
                            labelText: 'Mot de passe',
                            // New label
                            labelStyle: const TextStyle(
                              color: AppColors.darkBrownText,
                              fontSize: 16.0,
                            ),
                            filled: true,
                            fillColor: AppColors.inputBoxBrown,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                color: AppColors.darkBrownText,
                                width: 1.0,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 12.0,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordHidden
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: AppColors.darkBrownText,
                                size: 20.0,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordHidden = !_isPasswordHidden;
                                });
                              },
                            ),
                          ),
                          style: const TextStyle(
                            color: AppColors.darkBrownText,
                            fontSize: 16.0,
                          ),
                        ),
                        // "Forgot password?" link - Moved and restyled
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 8.0,
                            bottom: 8.0,
                          ), // Adjust vertical padding
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                            const RequestPasswordResetScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Mot de passe oublié', // New text
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: AppColors.mediumBrownLink,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Spacing before Login button, adjusted from 24 to accommodate link above
                        const SizedBox(height: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.darkBrownText,
                            // Dark brown background
                            foregroundColor: AppColors.whiteText,
                            // Text color
                            minimumSize: const Size(double.infinity, 50),
                            // Full width and 50px height
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                10.0,
                              ), // Rounded corners
                            ),
                          ),
                          onPressed: () => _login(context),
                          child: const Text(
                            'SE CONNECTER',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: AppColors.whiteText,
                            ),
                          ),
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
                        // "OU" Divider
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Row(
                            children: <Widget>[
                              const Expanded(
                                child: Divider(
                                  color: AppColors.darkBrownText,
                                  thickness: 1.0,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: Text(
                                  'OU',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: AppColors.darkBrownText,
                                  ),
                                ),
                              ),
                              const Expanded(
                                child: Divider(
                                  color: AppColors.darkBrownText,
                                  thickness: 1.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // const SizedBox(height: 16), // Adjusted spacing below
                        ElevatedButton(
                          // Changed from TextButton
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.inputBoxBrown,
                            // Lighter brown background
                            foregroundColor: AppColors.darkBrownText,
                            // Text color
                            minimumSize: const Size(double.infinity, 50),
                            // Full width and 50px height
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                10.0,
                              ), // Rounded corners
                            ),
                            // elevation: 0, // Optional: if a flatter look is desired
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder:
                                    (context) => const RegistrationScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'CRÉER UN COMPTE',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: AppColors.darkBrownText,
                            ),
                          ),
                        ),
                        // The SizedBox(height: 8) that was here is removed as "Forgot password?" moved
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Removed didChangeDependencies method as AuthGate now handles navigation
}
