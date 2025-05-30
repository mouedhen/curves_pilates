import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'common/services/api_service.dart';
import 'features/authentication/data/repositories/auth_repository.dart';
import 'features/authentication/domain/use_cases/login_use_case.dart';
import 'features/authentication/presentation/provider/auth_provider.dart';
// import 'features/authentication/presentation/screens/login_screen.dart'; // No longer primary home
import 'features/authentication/presentation/widgets/auth_gate.dart'; // Import AuthGate
import 'features/home/presentation/screens/home_screen.dart'; // Ensure HomeScreen is imported
import 'common/styling/app_colors.dart'; // Import AppColors

// void main() {
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService();
    final authRepository = AuthRepository(apiService);
    final loginUseCase = LoginUseCase(authRepository);
    final authProvider = AuthProvider(loginUseCase);

    return ChangeNotifierProvider(
      create: (context) => authProvider,
      child: MaterialApp(
        title: 'Flutter Auth Example',
        theme: ThemeData(
          fontFamily: 'Montserrat',
          scaffoldBackgroundColor: AppColors.beigeBackground,
          primaryColor: AppColors.darkBrownText,
          // textTheme: TextTheme( // Example of more detailed text theming
          //   bodyMedium: TextStyle(color: AppColors.darkBrownText),
          //   titleLarge: TextStyle(color: AppColors.darkBrownText, fontWeight: FontWeight.bold),
          // ),
          // appBarTheme: AppBarTheme( // Example of AppBar theming
          //   backgroundColor: Colors.transparent,
          //   elevation: 0,
          //   iconTheme: IconThemeData(color: AppColors.darkBrownText),
          //   titleTextStyle: TextStyle(
          //     color: AppColors.darkBrownText,
          //     fontSize: 20,
          //     fontFamily: 'Montserrat',
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
        ),
        home: const AuthGate(), // Use AuthGate as home
      ),
    );
  }
}