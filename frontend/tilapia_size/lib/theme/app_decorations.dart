import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppDecorations {
  AppDecorations._();

  /// Cream card used for the login / signup forms.
  static BoxDecoration card({double radius = 32}) => BoxDecoration(
        color: AppColors.paper,
        borderRadius: BorderRadius.circular(radius),
      );

  static OutlineInputBorder _border(Color color, [double width = 1]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: color, width: width),
      );

  static InputDecoration input(String label, IconData icon) => InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
        border: _border(const Color(0xFFD5DCE8)),
        enabledBorder: _border(const Color(0xFFD5DCE8)),
        focusedBorder: _border(AppColors.blueprint, 2),
        errorBorder: _border(AppColors.error),
        focusedErrorBorder: _border(AppColors.error, 2),
      );
}