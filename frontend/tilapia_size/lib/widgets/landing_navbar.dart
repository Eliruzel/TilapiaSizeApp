import 'package:flutter/material.dart';

import 'app_logo.dart';

class LandingNavbar extends StatelessWidget {
  const LandingNavbar({
    super.key,
    required this.onHome,
    required this.onFeatures,
    required this.onHowToUse,
    required this.onLogin,
    this.active = 'Home',
  });
  final VoidCallback onHome, onFeatures, onHowToUse, onLogin;
  final String active;

  @override
  Widget build(BuildContext context) => Container(
    key: const ValueKey('navbar'),
    decoration: const BoxDecoration(
      color: Color(0x16002030),
      border: Border(bottom: BorderSide(color: Color(0x20FFFFFF))),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1440),
        child: SizedBox(
          height: 84,
          child: Row(
            children: [
              const AppLogo(height: 56),
              const SizedBox(width: 14),
              if (MediaQuery.sizeOf(context).width >= 500)
                const Text(
                  'TILAPIA SIZE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              const Spacer(),
              if (MediaQuery.sizeOf(context).width < 700)
                PopupMenuButton<String>(
                  tooltip: 'Open navigation',
                  icon: const Icon(Icons.menu_rounded, color: Colors.white),
                  onSelected: (id) => {
                    'Home': onHome,
                    'Features': onFeatures,
                    'HowToUse': onHowToUse,
                    'Login': onLogin,
                  }[id]!(),
                  itemBuilder: (_) => const [
                    PopupMenuItem(value: 'Home', child: Text('Home')),
                    PopupMenuItem(value: 'Features', child: Text('Features')),
                    PopupMenuItem(value: 'HowToUse', child: Text('How To Use')),
                    PopupMenuItem(value: 'Login', child: Text('Login')),
                  ],
                )
              else ...[
                _link('Home', 'Home', onHome),
                _link('Features', 'Features', onFeatures),
                _link('How To Use', 'HowToUse', onHowToUse),
                const SizedBox(width: 16),
                OutlinedButton(
                  onPressed: onLogin,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Color(0x8097DDD5)),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 18,
                    ),
                  ),
                  child: const Text('Login'),
                ),
              ],
            ],
          ),
        ),
      ),
    ),
  );

  Widget _link(String label, String id, VoidCallback callback) => TextButton(
    onPressed: callback,
    style: TextButton.styleFrom(
      foregroundColor: active == id ? const Color(0xFF98E8D8) : Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
    ),
    child: Text(
      label,
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
    ),
  );
}
