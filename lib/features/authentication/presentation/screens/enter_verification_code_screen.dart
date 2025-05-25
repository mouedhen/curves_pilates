import 'package:flutter/material.dart';
import './reset_password_screen.dart'; // Import ResetPasswordScreen

class EnterVerificationCodeScreen extends StatefulWidget {
  final String email;
  final String verificationCode;

  const EnterVerificationCodeScreen({
    super.key,
    required this.email,
    required this.verificationCode,
  });

  @override
  State<EnterVerificationCodeScreen> createState() =>
      _EnterVerificationCodeScreenState();
}

class _EnterVerificationCodeScreenState
    extends State<EnterVerificationCodeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _verifyCode() {
    if (_formKey.currentState!.validate()) {
      final enteredCode = _codeController.text.trim();
      if (enteredCode == widget.verificationCode) {
        Navigator.of(context).pushReplacement( // Use pushReplacement
          MaterialPageRoute(
            builder: (context) => ResetPasswordScreen(email: widget.email),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Invalid verification code. Please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Verification Code'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'A verification code has been sent to ${widget.email}.',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _codeController,
                decoration:
                    const InputDecoration(labelText: 'Verification Code'),
                keyboardType: TextInputType.number,
                maxLength: 6,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the verification code';
                  }
                  if (value.length != 6) {
                    return 'Verification code must be 6 digits';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _verifyCode,
                child: const Text('Verify Code'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
