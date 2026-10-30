import 'package:flutter/material.dart';

import '../utils/section_navigation.dart';
import '../widgets/app_logo.dart';
import '../widgets/aquatic_background.dart';
import '../widgets/feature_card.dart';
import '../widgets/instruction_card.dart';
import '../widgets/landing_auth_card.dart';
import '../widgets/landing_navbar.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});
  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final _scroll = ScrollController();
  final _sections = {
    for (final id in ['Home', 'Features', 'HowToUse', 'Login'])
      id: GlobalKey(debugLabel: id),
  };
  AuthMode _mode = AuthMode.login;
  String _active = 'Home';
  int _authRevision = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _sections.containsKey(sectionFragment)) {
        _goTo(sectionFragment, animate: false);
      }
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _goTo(String id, {bool animate = true}) {
    FocusScope.of(context).unfocus();
    setState(() {
      _active = id;
      if (id == 'Login') {
        _mode = AuthMode.login;
        _authRevision++;
      }
    });
    setSectionFragment(id);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      Scrollable.ensureVisible(
        _sections[id]!.currentContext!,
        duration: animate ? const Duration(milliseconds: 450) : Duration.zero,
        curve: Curves.easeInOut,
        alignment: 0,
      );
    });
  }

  void _getStarted() {
    setState(() {
      _mode = AuthMode.signup;
      _authRevision++;
      _active = 'Login';
    });
    setSectionFragment('Login');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Scrollable.ensureVisible(
          _sections['Login']!.currentContext!,
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  Widget _section(String id, Widget child) => Semantics(
    key: _sections[id],
    identifier: id,
    container: true,
    explicitChildNodes: true,
    child: child,
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    body: AquaticBackground(
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            LandingNavbar(
              active: _active,
              onHome: () => _goTo('Home'),
              onFeatures: () => _goTo('Features'),
              onHowToUse: () => _goTo('HowToUse'),
              onLogin: () => _goTo('Login'),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, viewport) => SingleChildScrollView(
                  key: const ValueKey('landing-scroll'),
                  controller: _scroll,
                  child: Column(
                    children: [
                      _section('Home', _home(viewport)),
                      _section('Features', _features()),
                      _section(
                        'HowToUse',
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: viewport.maxHeight,
                          ),
                          child: _howTo(),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        color: const Color(0xFF042B3C),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 30,
                        ),
                        child: const Text(
                          '© 2026 TilapiaSize',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFC0DAD8),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget _home(BoxConstraints viewport) {
    final wide = viewport.maxWidth >= 980;
    final intro = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const AppLogo(height: 220),
        const SizedBox(height: 32),
        const Text(
          'A CLEARER PICTURE OF YOUR CATCH',
          style: TextStyle(
            color: Color(0xFF98E8D8),
            fontSize: 12,
            letterSpacing: 2.5,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'Know your tilapia\nsize at a glance.',
          style: TextStyle(
            color: Colors.white,
            fontSize: wide ? 54 : 36,
            height: 1.12,
            letterSpacing: -1.4,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'From a single catch to a growing collection of records.\nA simpler way to understand your tilapia.',
          style: TextStyle(color: Color(0xFFC0DCDE), fontSize: 17, height: 1.6),
        ),
        const SizedBox(height: 30),
        Wrap(
          spacing: 18,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            FilledButton.icon(
              onPressed: _getStarted,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF98E8D8),
                foregroundColor: const Color(0xFF073C49),
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 22,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              label: const Text(
                'Get Started',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              iconAlignment: IconAlignment.end,
              icon: const Icon(Icons.arrow_forward_rounded, size: 20),
            ),
            TextButton.icon(
              onPressed: () => _goTo('HowToUse'),
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              icon: const Icon(Icons.play_circle_outline_rounded),
              label: const Text('See how it works'),
            ),
          ],
        ),
      ],
    );
    final form = _section(
      'Login',
      ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460),
        child: LandingAuthCard(
          key: ValueKey(_authRevision),
          initialMode: _mode,
          onSubmit: (_, _, _) => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Account access is not connected yet. Your information has not been submitted.',
              ),
            ),
          ),
        ),
      ),
    );
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: viewport.maxHeight),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1400),
          padding: EdgeInsets.symmetric(
            horizontal: wide ? 48 : 24,
            vertical: wide ? 60 : 40,
          ),
          child: wide
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: intro),
                    const SizedBox(width: 80),
                    SizedBox(width: 460, child: form),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    intro,
                    const SizedBox(height: 48),
                    Center(child: form),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _features() => Container(
    width: double.infinity,
    color: const Color(0xFFF0F7F4),
    child: _sectionContent(
      children: [
        const Text(
          'BUILT AROUND YOUR CATCH',
          style: TextStyle(
            color: Color(0xFF148374),
            letterSpacing: 2,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'Features',
          style: TextStyle(
            fontSize: 40,
            color: Color(0xFF103C49),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'Three simple tools. A better understanding of your fish.',
          style: TextStyle(fontSize: 17, height: 1.6, color: Color(0xFF61777D)),
        ),
        const SizedBox(height: 40),
        _responsiveCards(const [
          FeatureCard(
            icon: Icons.set_meal_outlined,
            title: 'Classifies Fish',
            description: 'Identify and classify the fish in your capture, helping you organize each result before measuring.',
          ),
          FeatureCard(
            icon: Icons.straighten_rounded,
            title: 'Measure Size of Tilapia',
            description: 'Estimate your tilapia’s size from a clear image, so you can follow its growth and compare measurements.',
          ),
          FeatureCard(
            icon: Icons.folder_copy_outlined,
            title: 'Keeps Record',
            description: 'Save your captures and measurements together. Revisit past results and keep your fish records organized.',
          ),
        ], columns: 3),
      ],
    ),
  );

  Widget _howTo() => Container(
    width: double.infinity,
    color: const Color(0xFF073E50),
    child: _sectionContent(
      children: [
        const Text(
          'FROM CAMERA TO RECORD',
          style: TextStyle(
            color: Color(0xFF98E8D8),
            letterSpacing: 2,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'How To Use',
          style: TextStyle(
            fontSize: 40,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'A little preparation. A clear capture. A record you can return to.',
          style: TextStyle(fontSize: 17, height: 1.6, color: Color(0xFFB7D3D5)),
        ),
        const SizedBox(height: 40),
        _responsiveCards(const [
          InstructionCard(
            number: 1,
            icon: Icons.photo_camera_outlined,
            title: 'Ready Your Camera',
            description: 'Clean the lens and choose good lighting. Keep your camera steady for a clear view of the fish.',
          ),
          InstructionCard(
            number: 2,
            icon: Icons.table_restaurant_outlined,
            title: 'Find Flat Surface',
            description: 'Place the tilapia on a flat, uncluttered surface. Make sure its entire body is visible from above.',
          ),
          InstructionCard(
            number: 3,
            icon: Icons.camera_alt_outlined,
            title: 'Capture/Start Live/Upload',
            description: 'Take a photo, start a live camera session, or upload an existing image to begin checking your fish.',
          ),
          InstructionCard(
            number: 4,
            icon: Icons.save_outlined,
            title: 'Save Your Work',
            description: 'Review the result, then save the capture and measurement so you can find them in your records later.',
          ),
        ], columns: 4),
      ],
    ),
  );

  Widget _sectionContent({required List<Widget> children}) => Center(
    child: Container(
      constraints: const BoxConstraints(maxWidth: 1400),
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.sizeOf(context).width < 700 ? 24 : 48,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    ),
  );

  Widget _responsiveCards(List<Widget> cards, {required int columns}) =>
      LayoutBuilder(
        builder: (context, c) {
          final count = c.maxWidth < 620
              ? 1
              : c.maxWidth < 1050
              ? 2
              : columns;
          final width = (c.maxWidth - (count - 1) * 20) / count;
          return Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              for (final card in cards) SizedBox(width: width, child: card),
            ],
          );
        },
      );
}
