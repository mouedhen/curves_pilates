import 'package:flutter/material.dart';
import 'dart:math'; // For Random
import 'package:flutter/foundation.dart'; // For debugPrint, or use print
import './enter_verification_code_screen.dart';

class RequestPasswordResetScreen extends StatefulWidget {
  const RequestPasswordResetScreen({super.key});

  @override
  State<RequestPasswordResetScreen> createState() =>
      _RequestPasswordResetScreenState();
}

class _RequestPasswordResetScreenState
    extends State<RequestPasswordResetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _sendCode() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();

      // Generate a 6-digit random code
      final random = Random();
      final verificationCode =
          List.generate(6, (_) => random.nextInt(10)).join();

      // Print to console (using print for simplicity, debugPrint is also fine)
      print('Verification code for $email: $verificationCode');

      // Navigate to EnterVerificationCodeScreen
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EnterVerificationCodeScreen(
            email: email,
            verificationCode: verificationCode,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center the column content
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email Address'), // const added
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email address';
                  }
                  if (!value.contains('@')) { // Basic email check
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24), // const added
              ElevatedButton(
                onPressed: _sendCode,
                child: const Text('Send Verification Code'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
