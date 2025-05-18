import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'common/services/api_service.dart';
import 'features/authentication/data/repositories/auth_repository.dart';
import 'features/authentication/domain/use_cases/login_use_case.dart';
import 'features/authentication/presentation/provider/auth_provider.dart';
import 'features/authentication/presentation/screens/login_screen.dart';

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
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const LoginScreen(),
      ),
    );
  }
}