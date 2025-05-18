import 'package:flutter/material.dart';
import 'app.dart'; // Assuming your main app widget is in app.dart

void main() async {
  // Ensure Flutter binding is initialized (important for plugins, etc.)
  WidgetsFlutterBinding.ensureInitialized();

  // Optional: Initialize other global services here
  // await Firebase.initializeApp();
  // await SharedPreferences.getInstance();

  runApp(const MyApp()); // Run the root app widget
}