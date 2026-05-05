import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:matchie/main.dart';

void main() {
  testWidgets('prototype opens the premium shell with seven tabs', (
    tester,
  ) async {
    final binding = TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => binding.setSurfaceSize(null));

    await tester.pumpWidget(const MatchiePrototypeApp());

    expect(find.text('Matchie'), findsOneWidget);
    expect(find.text('Create account'), findsOneWidget);

    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle();

    expect(find.byType(Image), findsWidgets);
    expect(find.text('The whole you, not just a CV.'), findsNothing);
    expect(find.textContaining('Build your career'), findsNothing);
    expect(find.bySemanticsLabel('Home'), findsOneWidget);
    expect(find.bySemanticsLabel('Profile'), findsOneWidget);
    expect(find.bySemanticsLabel('Jobs'), findsOneWidget);
    expect(find.bySemanticsLabel('MatchieAI'), findsOneWidget);
    expect(find.bySemanticsLabel('Matchie on the Go'), findsWidgets);
    expect(find.bySemanticsLabel('Support'), findsWidgets);
    expect(find.bySemanticsLabel('Settings'), findsOneWidget);
    expect(find.byIcon(Icons.menu_rounded), findsOneWidget);
  });

  testWidgets('bottom navigation opens jobs and profile hubs', (tester) async {
    final binding = TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => binding.setSurfaceSize(null));

    await tester.pumpWidget(const MatchiePrototypeApp());
    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle();

    await tester.tap(find.bySemanticsLabel('Jobs'));
    await tester.pumpAndSettle();

    expect(find.text('Job Matches'), findsOneWidget);
    expect(find.text('Product Manager, Amazon Now'), findsWidgets);
    expect(find.text('Profile scan complete'), findsOneWidget);

    await tester.tap(find.bySemanticsLabel('Profile'));
    await tester.pumpAndSettle();

    expect(find.text('Chetan Jain'), findsWidgets);
    expect(find.text('Profile Strength'), findsOneWidget);
    expect(find.text('Overview'), findsOneWidget);
    expect(find.text('Sources'), findsOneWidget);
  });
}
