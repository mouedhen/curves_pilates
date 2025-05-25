import 'package:flutter/material.dart';
import 'dart:math'; // For Random
import 'package:flutter/foundation.dart'; // For debugPrint, or use print
import './enter_verification_code_screen.dart';
import '../../../../common/styling/app_colors.dart'; // Import AppColors

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
      backgroundColor: Colors.white, // Set scaffold background to white
      appBar: AppBar(
        title: const Text(
          'Réinitialisation du mot de passe', // New title
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
            color: AppColors.darkGrayInputText,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white, // Match scaffold background
        elevation: 0, // Remove shadow for a flatter look
        iconTheme: const IconThemeData(
          color: AppColors.darkGrayInputText, // For back arrow
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center the column content
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0), // Add some space below the instruction
                child: Text(
                  'Entrez votre adresse e-mail pour recevoir les instructions de réinitialisation.', // Refined instruction text
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0, // 14-16px range
                    color: AppColors.mediumGrayText,
                  ),
                ),
              ),
              // New structure for Email field with external label
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Adresse e-mail ou numéro de téléphone', // New label text
                    style: TextStyle(
                      fontSize: 15.0,
                      color: AppColors.mediumGrayText,
                    ),
                  ),
                  const SizedBox(height: 8.0), // Space between label and field
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: AppColors.darkGrayInputText, fontSize: 16.0),
                    decoration: InputDecoration(
                      hintText: 'exemple@domaine.com', // Placeholder text
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: AppColors.lightGrayBorder, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: AppColors.lightGrayBorder, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: AppColors.brandColor, width: 1.5),
                      ),
                      hintStyle: const TextStyle(color: AppColors.placeholderGray, fontSize: 16.0),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email address';
                      }
                      if (!value.contains('@')) { // Basic email check, can be more sophisticated
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24), // This SizedBox is now after the new Column
              SizedBox( // Ensure full width
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.brandColor, // Brand color
                    foregroundColor: AppColors.whiteText, // Text color
                    minimumSize: const Size(double.infinity, 52), // Full width and 52px height
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Rounded corners (e.g., 8px)
                    ),
                  ),
                  onPressed: _sendCode,
                  child: const Text(
                    'Envoyer un lien de réinitialisation', // New label
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.whiteText,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0), // Spacing after the button
              const Text( // Help Text
                'Si vous ne recevez pas d’e-mail, vérifiez votre dossier spam ou réessayez.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.0, // 12-14px range
                  color: AppColors.mediumGrayText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
