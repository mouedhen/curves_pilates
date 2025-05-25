import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // For debugPrint
import '../../../../common/styling/app_colors.dart'; // Import AppColors

// Assuming LoginScreen is the target to return to.
// If AuthGate is the first route, this navigation might need adjustment
// depending on how AuthGate handles being "returned to" after a popUntil.
// For this task, we'll use popUntil((route) => route.isFirst) as specified.
// import './login_screen.dart'; // Not strictly needed for popUntil route.isFirst

class ResetPasswordScreen extends StatefulWidget {
  final String email;

  const ResetPasswordScreen({
    super.key,
    required this.email,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isNewPasswordHidden = true; // Added state variable
  bool _isConfirmPasswordHidden = true; // Added state variable

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _changePassword() {
    if (_formKey.currentState!.validate()) {
      final newPassword = _newPasswordController.text;

      debugPrint(
          'Password for ${widget.email} changed successfully to: $newPassword');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password changed successfully!')),
      );

      // Navigate back to the first screen in the stack (usually LoginScreen or AuthGate)
      Navigator.of(context).popUntil((route) => route.isFirst);
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
            crossAxisAlignment: CrossAxisAlignment.stretch, // Make button full width
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0), // Add some space below the instruction
                child: Text(
                  'Veuillez entrer un nouveau mot de passe sécurisé et le confirmer ci-dessous.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0, // 14-16px range
                    color: AppColors.mediumGrayText,
                  ),
                ),
              ),
              // New Password Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nouveau mot de passe',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: AppColors.mediumGrayText,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: _newPasswordController,
                    obscureText: _isNewPasswordHidden,
                    style: const TextStyle(color: AppColors.darkGrayInputText, fontSize: 16.0),
                    decoration: InputDecoration(
                      hintText: 'Au moins 8 caractères', // Placeholder
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
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isNewPasswordHidden ? Icons.visibility_off : Icons.visibility,
                          color: AppColors.mediumGrayText,
                        ),
                        onPressed: () {
                          setState(() {
                            _isNewPasswordHidden = !_isNewPasswordHidden;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un nouveau mot de passe';
                      }
                      if (value.length < 8) {
                        return 'Le mot de passe doit comporter au moins 8 caractères';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Confirm New Password Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Confirmer le mot de passe',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: AppColors.mediumGrayText,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _isConfirmPasswordHidden,
                    style: const TextStyle(color: AppColors.darkGrayInputText, fontSize: 16.0),
                    decoration: InputDecoration(
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
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isConfirmPasswordHidden ? Icons.visibility_off : Icons.visibility,
                          color: AppColors.mediumGrayText,
                        ),
                        onPressed: () {
                          setState(() {
                            _isConfirmPasswordHidden = !_isConfirmPasswordHidden;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez confirmer votre nouveau mot de passe'; // French error
                      }
                      if (value != _newPasswordController.text) {
                        return 'Les mots de passe ne correspondent pas'; // French error
                      }
                      return null;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brandColor, // Brand color
                  foregroundColor: AppColors.whiteText, // Text color
                  minimumSize: const Size(double.infinity, 52), // Full width and 52px height
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), // Rounded corners (e.g., 8px)
                  ),
                ),
                onPressed: _changePassword,
                child: const Text(
                  'Réinitialiser le mot de passe', // New label
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteText,
                  ),
                ),
              ),
              const SizedBox(height: 16.0), // Spacing after the button
              const Text( // Help Text
                'Assurez-vous que votre mot de passe comporte au moins 8 caractères, y compris des lettres et des chiffres.',
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
