import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tilapia_size/app.dart';
import 'package:tilapia_size/widgets/landing_auth_card.dart';

void main() {
  for (final size in [
    const Size(1920, 1080),
    const Size(1024, 768),
    const Size(390, 844),
  ]) {
    testWidgets('Forms fit and retain their size at $size', (tester) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(const TilapiaSizeApp());
      await tester.pumpAndSettle();
      final card = find.byType(LandingAuthCard);
      final loginSize = tester.getSize(card);
      expect(loginSize.height, 520);
      await tester.ensureVisible(find.text('Sign Up'));
      await tester.tap(find.text('Sign Up'));
      await tester.pumpAndSettle();
      expect(tester.getSize(card), loginSize);
      final inner = tester.state<ScrollableState>(
        find.descendant(of: card, matching: find.byType(Scrollable)).first,
      );
      expect(
        inner.position.maxScrollExtent,
        0,
        reason: 'All signup controls must fit inside the card.',
      );
      expect(find.text('Classifies Fish'), findsOneWidget);
      expect(find.text('Measure Size of Tilapia'), findsOneWidget);
      expect(find.text('Keeps Record'), findsOneWidget);
      expect(find.text('Ready Your Camera'), findsOneWidget);
      expect(find.text('Find Flat Surface'), findsOneWidget);
      expect(find.text('Capture/Start Live/Upload'), findsOneWidget);
      expect(find.text('Save Your Work'), findsOneWidget);
      await tester.tap(find.text('Create account'));
      await tester.pumpAndSettle();
      expect(find.text('Name is required'), findsOneWidget);
      expect(find.text('Enter your email address'), findsOneWidget);
      expect(tester.getSize(card), loginSize);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('Section navigation is anchored below a pinned navbar', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1920, 1080);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const TilapiaSizeApp());
    await tester.pumpAndSettle();
    final navbar = find.byKey(const ValueKey('navbar'));
    final navRect = tester.getRect(navbar);
    Finder section(String id) => find.byWidgetPredicate(
      (w) => w is Semantics && w.properties.identifier == id,
    );
    expect(tester.getRect(section('Home')).height, 1080 - navRect.bottom);
    for (final id in ['Features', 'HowToUse', 'Home']) {
      final label = id == 'HowToUse' ? 'How To Use' : id;
      await tester.tap(find.text(label).first);
      await tester.pumpAndSettle();
      expect(tester.getRect(navbar), navRect);
      expect(tester.getTopLeft(section(id)).dy, closeTo(navRect.bottom, 1));
    }
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();
    expect(find.text('Create account'), findsOneWidget);
    await tester.tap(find.text('Login').first);
    await tester.pumpAndSettle();
    expect(find.text('Log in'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
