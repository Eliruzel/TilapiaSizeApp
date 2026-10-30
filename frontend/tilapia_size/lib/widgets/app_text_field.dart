import 'package:flutter/material.dart';

import '../theme/app_decorations.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.validator,
    this.keyboardType,
    this.isPassword = false,
    this.compact = false,
    this.textInputAction,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool isPassword;
  final bool compact;
  final TextInputAction? textInputAction;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _hidden = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: widget.compact ? 14 : 16),
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      obscureText: widget.isPassword && _hidden,
      validator: widget.validator,
      decoration: AppDecorations.input(widget.label, widget.icon).copyWith(
        isDense: widget.compact,
        contentPadding: widget.compact
            ? const EdgeInsets.symmetric(horizontal: 14, vertical: 12)
            : null,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _hidden
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
                onPressed: () => setState(() => _hidden = !_hidden),
              )
            : null,
      ),
    );
  }
}
