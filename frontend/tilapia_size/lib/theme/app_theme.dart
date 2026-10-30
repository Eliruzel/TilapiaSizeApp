import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.blueprint,
          primary: AppColors.blueprint,
          secondary: AppColors.gold,
        ),
        scaffoldBackgroundColor: AppColors.blueprint,
      );
}