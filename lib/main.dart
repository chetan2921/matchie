import 'package:flutter/material.dart';

import 'prototype_screens.dart';
import 'prototype_shell.dart';
import 'prototype_theme.dart';

void main() {
  runApp(const MatchiePrototypeApp());
}

class MatchiePrototypeApp extends StatelessWidget {
  const MatchiePrototypeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Matchie Prototype',
      debugShowCheckedModeBanner: false,
      theme: buildMatchieTheme(),
      home: const _PrototypeEntry(),
    );
  }
}

class _PrototypeEntry extends StatelessWidget {
  const _PrototypeEntry();

  @override
  Widget build(BuildContext context) {
    return WelcomeScreen(
      onCreateAccount: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) =>
                OnboardingStartScreen(onFinish: () => _enterPrototype(context)),
          ),
        );
      },
      onSignIn: () => _enterPrototype(context),
    );
  }

  void _enterPrototype(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => const MatchieShell()),
      (route) => false,
    );
  }
}
