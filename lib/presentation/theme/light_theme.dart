import 'package:flutter/material.dart';
import 'package:financas_pessoais/presentation/theme/app_colors.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.lightBackground,
  colorScheme: const ColorScheme.light(
    primary: AppColors.primaryGreen,
    onPrimary: Colors.white,
    secondary: AppColors.accentTeal,
    onSecondary: Colors.white,
    surface: AppColors.lightSurface,
    onSurface: AppColors.onSurfaceDarkText,
    error: AppColors.errorColor,
    onError: Colors.white,
    brightness: Brightness.light,
  ),

  textTheme: const TextTheme(
    displayLarge: TextStyle(color: AppColors.onSurfaceDarkText),
    displayMedium: TextStyle(color: AppColors.onSurfaceDarkText),
    displaySmall: TextStyle(color: AppColors.onSurfaceDarkText),
    headlineLarge: TextStyle(color: AppColors.onSurfaceDarkText),
    headlineMedium: TextStyle(color: AppColors.onSurfaceDarkText),
    headlineSmall: TextStyle(color: AppColors.onSurfaceDarkText),
    titleLarge: TextStyle(color: AppColors.onSurfaceDarkText),
    titleMedium: TextStyle(color: AppColors.onSurfaceDarkText),
    titleSmall: TextStyle(color: AppColors.onSurfaceDarkText),
    bodyLarge: TextStyle(color: AppColors.onSurfaceDarkText),
    bodyMedium: TextStyle(color: AppColors.onSurfaceDarkText),
    bodySmall: TextStyle(color: AppColors.secondaryDarkText),
    labelLarge: TextStyle(color: AppColors.onSurfaceDarkText),
    labelMedium: TextStyle(color: AppColors.secondaryDarkText),
    labelSmall: TextStyle(color: AppColors.secondaryDarkText),
  ),

  iconTheme: const IconThemeData(color: AppColors.onSurfaceDarkText),

  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.lightSurface,
    foregroundColor: AppColors.onSurfaceDarkText,
    elevation: 1,
    titleTextStyle: TextStyle(
      color: AppColors.onSurfaceDarkText,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: AppColors.onSurfaceDarkText),
  ),

  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.accentTeal,
    foregroundColor: Colors.white,
    shape: CircleBorder(),
  ),

  cardTheme: CardThemeData(
    color: AppColors.lightSurface,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryGreen,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.accentTeal,
      textStyle: const TextStyle(fontSize: 16),
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.primaryGreen,
      side: const BorderSide(color: AppColors.primaryGreen),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      textStyle: const TextStyle(fontSize: 16),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.lightSurface,
    labelStyle: const TextStyle(color: AppColors.secondaryDarkText),
    hintStyle: const TextStyle(color: AppColors.secondaryDarkText),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: AppColors.secondaryDarkText,
        width: 1,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.accentTeal, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: AppColors.secondaryDarkText,
        width: 1,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.errorColor, width: 1),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.errorColor, width: 2),
    ),
  ),
);
