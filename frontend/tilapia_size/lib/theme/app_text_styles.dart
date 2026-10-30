import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const nav = TextStyle(
    color: AppColors.white,
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );

  static const headline = TextStyle(
    color: AppColors.white,
    fontSize: 40,
    height: 1.1,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.5,
  );

  static const body = TextStyle(
    color: Color(0xE6FFFFFF),
    fontSize: 17,
    height: 1.5,
  );

  static const cardTitle = TextStyle(
    color: AppColors.ink,
    fontSize: 24,
    fontWeight: FontWeight.w800,
  );

  static const cardBody = TextStyle(
    color: AppColors.mutedInk,
    fontSize: 14,
    height: 1.4,
  );

  static const button = TextStyle(
    color: AppColors.ink,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );
}