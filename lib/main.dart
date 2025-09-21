import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'constants/app_colors.dart';
import 'constants/app_strings.dart';

void main() {
  runApp(const BrattiTecnologiaApp());
}

class BrattiTecnologiaApp extends StatelessWidget {
  const BrattiTecnologiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.background,
          elevation: 0,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
