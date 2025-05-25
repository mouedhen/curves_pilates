import 'package:flutter/material.dart';
import '../../../../common/styling/app_colors.dart'; // Import AppColors

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // Text Editing Controllers
  final _nameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // State variables for Dropdown and Checkbox
  String? _selectedTitle;
  bool _agreedToTerms = false;
  bool _isNewPasswordHidden = true; // For New Password field
  bool _isConfirmPasswordHidden = true; // For Confirm Password field

  // Form Key
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _firstNameController.dispose();
    _birthDateController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set scaffold background to white
      appBar: AppBar(
        title: const Text(
          'Inscription',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: _buildRegistrationForm(context),
          ),
        ),
      ),
    );
  }

  Widget _buildRegistrationForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Name Field
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nom',
              style: TextStyle(fontSize: 15.0, color: AppColors.mediumGrayText),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: _nameController,
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
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
          ],
        ),
        const SizedBox(height: 16.0),

        // First Name Field
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Prénom',
              style: TextStyle(fontSize: 15.0, color: AppColors.mediumGrayText),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: _firstNameController,
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
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your first name';
                }
                return null;
              },
            ),
          ],
        ),
        const SizedBox(height: 16.0),

        // Birth Date Field
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Date de naissance',
              style: TextStyle(fontSize: 15.0, color: AppColors.mediumGrayText),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: _birthDateController,
              style: const TextStyle(color: AppColors.darkGrayInputText, fontSize: 16.0),
              decoration: InputDecoration(
                hintText: 'YYYY-MM-DD',
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
                  return 'Please enter your birth date';
                }
                return null;
              },
            ),
          ],
        ),
        const SizedBox(height: 16.0),

        // Phone Number Field
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Numéro de téléphone',
              style: TextStyle(fontSize: 15.0, color: AppColors.mediumGrayText),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: _phoneController,
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
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
            ),
          ],
        ),
        const SizedBox(height: 16.0),

        // Complete Address Field
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Adresse complète',
              style: TextStyle(fontSize: 15.0, color: AppColors.mediumGrayText),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: _addressController,
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
              ),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your complete address';
                }
                return null;
              },
            ),
          ],
        ),
        const SizedBox(height: 16.0),

        // Title Field - Dropdown styling can also be adjusted if needed, but this task focuses on TextFormField
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Titre',
              style: TextStyle(fontSize: 15.0, color: AppColors.mediumGrayText),
            ),
            const SizedBox(height: 8.0),
            DropdownButtonFormField<String>(
              decoration: InputDecoration( // Apply similar decoration for consistency
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
              ),
              value: _selectedTitle,
              style: const TextStyle(color: AppColors.darkGrayInputText, fontSize: 16.0),
              validator: (value) {
                if (value == null) {
                  return 'Please select a title';
                }
                return null;
              },
              items: ['Madame', 'Mademoiselle', 'Monsieur'].map((String value) { // Updated to French terms
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value), // Text style for items in dropdown list itself
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedTitle = newValue;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 16.0),

        // Email Address Field
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Adresse e-mail',
              style: TextStyle(fontSize: 15.0, color: AppColors.mediumGrayText),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: _emailController,
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
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email address';
                }
                if (!value.contains('@') || !value.contains('.')) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
          ],
        ),
        const SizedBox(height: 16.0),

        // Password Field
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mot de passe',
              style: TextStyle(fontSize: 15.0, color: AppColors.mediumGrayText),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: _passwordController,
              style: const TextStyle(color: AppColors.darkGrayInputText, fontSize: 16.0),
              obscureText: _isNewPasswordHidden,
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
                  return 'Please enter a password';
                }
                if (value.length < 6) { 
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
          ],
        ),
        const SizedBox(height: 16.0),

        // Confirm Password Field
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Confirmer le mot de passe',
              style: TextStyle(fontSize: 15.0, color: AppColors.mediumGrayText),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: _confirmPasswordController,
              style: const TextStyle(color: AppColors.darkGrayInputText, fontSize: 16.0),
              obscureText: _isConfirmPasswordHidden,
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
                  return 'Please confirm your password';
                }
                if (value != _passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        
        CheckboxListTile(
          title: const Text(
            "J'accepte les conditions d'utilisation de Curves", // New label text
            style: TextStyle(
              fontSize: 15.0, // 14-16px range
              color: AppColors.mediumGrayText,
              // fontWeight: FontWeight.normal, // Default
            ),
          ),
          value: _agreedToTerms,
          onChanged: (bool? newValue) {
            setState(() {
              _agreedToTerms = newValue ?? false;
            });
          },
          activeColor: AppColors.brandColor, // Color when checked
          controlAffinity: ListTileControlAffinity.leading,
          // dense: true, // Optional: if a more compact look is desired
        ),
        const SizedBox(height: 16.0),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.brandColor, // Brand color
              foregroundColor: AppColors.whiteText, // Text color
              minimumSize: const Size(double.infinity, 52), // Full width and 52px height
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0), // Rounded corners
              ),
              // textStyle: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold), // Can be defined here too
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (_agreedToTerms) {
                  // For debugging - print values
                  print('Name: ${_nameController.text}');
                  print('First Name: ${_firstNameController.text}');
                  print('Birth Date: ${_birthDateController.text}');
                  print('Phone: ${_phoneController.text}');
                  print('Address: ${_addressController.text}');
                  print('Title: $_selectedTitle');
                  print('Email: ${_emailController.text}');
                  // Do not print password in real apps
                  // print('Password: ${_passwordController.text}');

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Registration Submitted (Not Implemented)')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please accept the terms and conditions')),
                  );
                }
              }
            },
            child: const Text(
              'CONTINUER',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: AppColors.whiteText,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
