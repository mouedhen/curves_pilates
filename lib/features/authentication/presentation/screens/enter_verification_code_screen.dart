import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart'; // Import Pinput
import './reset_password_screen.dart'; // Import ResetPasswordScreen
import '../../../../common/styling/app_colors.dart'; // Import AppColors

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
  // final _formKey = GlobalKey<FormState>(); // No longer needed if Pinput is the only field and validated directly
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _verifyCode() {
    final enteredCode = _codeController.text.trim();
    if (enteredCode.length == 6) { // Check length directly
      if (enteredCode == widget.verificationCode) {
        Navigator.of(context).pushReplacement(
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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter all 6 digits of the code.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: AppColors.darkGrayInputText,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.lightGrayBorder, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.brandColor, width: 1.5),
      borderRadius: BorderRadius.circular(8.0),
    );

    final submittedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.brandColor, width: 1.0), // Or a success color
      // color: Colors.white, // Or a slightly different color like a very light gray
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Vérification du code',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
            color: AppColors.darkGrayInputText,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: AppColors.darkGrayInputText,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form( // Form can still be useful if other fields were present or for overall structure
          // key: _formKey, // Not strictly necessary if Pinput handles its own validation display or we do it manually
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Veuillez entrer le code à 6 chiffres envoyé à ${widget.email}.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15.0,
                  color: AppColors.mediumGrayText,
                ),
              ),
              const SizedBox(height: 24.0),
              const Text( // Label for Pinput
                'Code de vérification',
                style: TextStyle(
                  fontSize: 15.0,
                  color: AppColors.mediumGrayText,
                ),
              ),
              const SizedBox(height: 8.0),
              Pinput(
                controller: _codeController,
                length: 6,
                autofocus: true,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                validator: (s) {
                  if (s == null || s.length != 6) {
                    return 'Code must be 6 digits';
                  }
                  return null;
                },
                onCompleted: (pin) {
                  // print('Pinput completed: $pin');
                },
              ),
              // const SizedBox(height: 24), // Original SizedBox before "Verify Code" button
              // "Renvoyer le code" TextButton
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      // Placeholder action for resending code
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Renvoyer le code (Non implémenté)')),
                      );
                      // In a real app, you would trigger logic to resend the code here.
                      // This might involve calling a method in AuthProvider.
                    },
                    child: const Text(
                      'Renvoyer le code',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: AppColors.brandColor,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.brandColor,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16), // Adjusted spacing before the main action button
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
                  onPressed: _verifyCode,
                  child: const Text(
                    'Confirmer', // New label
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
                'Si vous ne recevez pas de code, vérifiez votre dossier spam ou réessayez.',
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
