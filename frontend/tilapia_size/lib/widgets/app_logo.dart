import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.height = 48});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo-mark.png',
      height: height,
      semanticLabel: 'TilapiaSize logo',
      fit: BoxFit.contain,
      errorBuilder: (_, _, _) => Text(
        'TILAPIA SIZE',
        style: TextStyle(
          color: AppColors.white,
          fontSize: height * 0.4,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
