import 'package:flutter/material.dart';

import '../utils/validators.dart';
import 'app_text_field.dart';

enum AuthMode { login, signup }

class LandingAuthCard extends StatefulWidget {
  const LandingAuthCard({
    super.key,
    this.initialMode = AuthMode.login,
    required this.onSubmit,
  });
  final AuthMode initialMode;
  final void Function(AuthMode mode, String email, String password) onSubmit;
  @override
  State<LandingAuthCard> createState() => _LandingAuthCardState();
}

class _LandingAuthCardState extends State<LandingAuthCard> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  late AuthMode _mode = widget.initialMode;
  bool get _isLogin => _mode == AuthMode.login;

  @override
  void didUpdateWidget(covariant LandingAuthCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialMode != widget.initialMode) {
      _switch(widget.initialMode);
    }
  }

  void _switch(AuthMode mode) {
    _formKey.currentState?.reset();
    setState(() {
      _mode = mode;
      _password.clear();
      _confirm.clear();
    });
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(_mode, _email.text.trim(), _password.text);
    }
  }

  @override
  Widget build(BuildContext context) => Container(
    height: 520,
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(
      color: const Color(0xFFF9FCFB),
      borderRadius: BorderRadius.circular(28),
      border: Border.all(color: Colors.white),
      boxShadow: const [
        BoxShadow(
          color: Color(0x26001625),
          blurRadius: 48,
          offset: Offset(0, 20),
        ),
      ],
    ),
    child: SingleChildScrollView(
      key: const ValueKey('auth-scroll'),
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFFE7F0EF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  _tab('Login', AuthMode.login),
                  _tab('Sign Up', AuthMode.signup),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _isLogin ? 'Welcome back.' : 'Get started.',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Color(0xFF123C49),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              _isLogin
                  ? 'Your next measurement starts here.'
                  : 'Keep your catch organized.',
              style: const TextStyle(
                fontSize: 12,
                height: 1.4,
                color: Color(0xFF627A80),
              ),
            ),
            SizedBox(height: _isLogin ? 24 : 14),
            if (!_isLogin) ...[
              AppTextField(
                controller: _name,
                compact: true,
                label: 'Full name',
                icon: Icons.person_outline,
                validator: (v) => Validators.required(v, field: 'Name'),
              ),
              const SizedBox(height: 8),
            ],
            AppTextField(
              controller: _email,
              compact: true,
              label: 'Email address',
              icon: Icons.mail_outline,
              keyboardType: TextInputType.emailAddress,
              validator: Validators.email,
            ),
            const SizedBox(height: 8),
            AppTextField(
              controller: _password,
              compact: true,
              label: 'Password',
              icon: Icons.lock_outline,
              isPassword: true,
              validator: Validators.password,
            ),
            if (!_isLogin) ...[
              const SizedBox(height: 8),
              AppTextField(
                controller: _confirm,
                compact: true,
                label: 'Confirm password',
                icon: Icons.lock_outline,
                isPassword: true,
                validator: (v) => Validators.confirmPassword(v, _password.text),
              ),
            ],
            SizedBox(height: _isLogin ? 24 : 14),
            SizedBox(
              height: 46,
              child: FilledButton(
                onPressed: _submit,
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF086775),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  _isLogin ? 'Log in' : 'Create account',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
            if (_isLogin) ...[
              const SizedBox(height: 24),
              const Divider(color: Color(0xFFDDE9E7)),
              const SizedBox(height: 12),
              const Text(
                'Measure. Understand. Keep growing.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Color(0xFF627A80)),
              ),
            ],
          ],
        ),
      ),
    ),
  );

  Widget _tab(String text, AuthMode mode) => Expanded(
    child: TextButton(
      onPressed: () => _switch(mode),
      style: TextButton.styleFrom(
        backgroundColor: _mode == mode ? Colors.white : Colors.transparent,
        foregroundColor: const Color(0xFF185663),
        minimumSize: const Size(0, 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w700)),
    ),
  );
}
