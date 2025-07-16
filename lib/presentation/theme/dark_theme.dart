import 'package:flutter/material.dart';
import 'package:financas_pessoais/presentation/theme/app_colors.dart';

final ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.darkBackground,
  colorScheme: const ColorScheme.dark(
    primary: AppColors.primaryGreen,
    onPrimary: AppColors.onSurfaceText,
    secondary: AppColors.accentTeal,
    onSecondary: AppColors.onSurfaceText,
    surface: AppColors.darkSurface,
    onSurface: AppColors.onSurfaceText,
    error: AppColors.errorColor,
    onError: AppColors.onSurfaceText,
    brightness: Brightness.dark,
  ),

  textTheme: const TextTheme(
    displayLarge: TextStyle(color: AppColors.onSurfaceText),
    displayMedium: TextStyle(color: AppColors.onSurfaceText),
    displaySmall: TextStyle(color: AppColors.onSurfaceText),
    headlineLarge: TextStyle(color: AppColors.onSurfaceText),
    headlineMedium: TextStyle(color: AppColors.onSurfaceText),
    headlineSmall: TextStyle(color: AppColors.onSurfaceText),
    titleLarge: TextStyle(color: AppColors.onSurfaceText),
    titleMedium: TextStyle(color: AppColors.onSurfaceText),
    titleSmall: TextStyle(color: AppColors.onSurfaceText),
    bodyLarge: TextStyle(color: AppColors.onSurfaceText),
    bodyMedium: TextStyle(color: AppColors.onSurfaceText),
    bodySmall: TextStyle(color: AppColors.secondaryText),
    labelLarge: TextStyle(color: AppColors.onSurfaceText),
    labelMedium: TextStyle(color: AppColors.secondaryText),
    labelSmall: TextStyle(color: AppColors.secondaryText),
  ),

  iconTheme: const IconThemeData(color: AppColors.onSurfaceText),

  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.darkSurface,
    foregroundColor: AppColors.onSurfaceText,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: AppColors.onSurfaceText,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: AppColors.onSurfaceText),
  ),

  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.accentTeal,
    foregroundColor: Colors.white,
    shape: CircleBorder(),
  ),

  cardTheme: CardThemeData(
    color: AppColors.darkSurface,
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
    fillColor: AppColors.darkSurface,
    labelStyle: const TextStyle(color: AppColors.secondaryText),
    hintStyle: TextStyle(color: AppColors.secondaryText.withValues(alpha: 0.7)),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.secondaryText, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.accentTeal, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.secondaryText, width: 1),
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
