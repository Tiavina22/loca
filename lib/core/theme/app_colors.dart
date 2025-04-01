import 'package:flutter/material.dart';

class AppColors {
  // Colors principal
  static const primaryColor = Color(0xFF2196F3); // Blue 500
  static const secondaryColor = Color(0xFF1565C0); // Blue 800

  // Background colors
  static const backgroundColor = Color(0xFFFFFFFF);
  static const surfaceColor = Color(0xFFF5F5F5);
  static const cardColor = Color(0xFFFFFFFF);

  // Text colors
  static const textPrimaryColor = Color(0xFF212121);
  static const textSecondaryColor = Color(0xFF757575);
  static const textHintColor = Color(0xFFBDBDBD);

  // Status colors
  static const successColor = Color(0xFF4CAF50);
  static const errorColor = Color(0xFFE53935);
  static const warningColor = Color(0xFFFF9800);
  static const infoColor = primaryColor;

  // Input colors
  static const inputBackgroundColor = surfaceColor;
  static const inputBorderColor = Color(0xFFE0E0E0);
  static const inputFocusedBorderColor = primaryColor;

  // Button colors
  static final buttonColor = primaryColor;
  static const buttonTextColor = Colors.white;
  static final buttonDisabledColor = Colors.grey[300];

  // Gradients
  static const primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryColor, secondaryColor],
  );
}
