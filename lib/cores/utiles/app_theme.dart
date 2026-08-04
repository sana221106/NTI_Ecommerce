import 'package:ecommerce/cores/utiles/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primaryColor: AppColors.Textblack,
    scaffoldBackgroundColor: AppColors.primaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      elevation: 0,
    ),
  );
  static final darkTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.Textblack,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.Textblack,
      elevation: 0,
    ),
  );
}
