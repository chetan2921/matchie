import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchiePalette {
  const MatchiePalette._();

  static const Color ink = Color(0xFF101015);
  static const Color midnight = Color(0xFF08080C);
  static const Color panel = Color(0xFF1F1F25);
  static const Color panelSoft = Color(0xFF292832);
  static const Color nav = Color(0xFF09090D);
  static const Color outline = Color(0xFF34313D);
  static const Color glass = Color(0x66FFFFFF);
  static const Color glassSoft = Color(0x24FFFFFF);
  static const Color text = Color(0xFFF5F4FF);
  static const Color muted = Color(0xFFB9B5C3);
  static const Color faint = Color(0xFF8D8896);
  static const Color blue = Color(0xFF0B42FF);
  static const Color cyan = Color(0xFF20D4E8);
  static const Color purple = Color(0xFFA84DFF);
  static const Color pink = Color(0xFFFF4FA3);
  static const Color red = Color(0xFFFF0808);
  static const Color green = Color(0xFF43D39E);
  static const Color yellow = Color(0xFFD7A8FF);
  static const Color warm = Color(0xFF3B2455);
}

class MatchieGradients {
  const MatchieGradients._();

  static const LinearGradient brand = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [MatchiePalette.blue, MatchiePalette.purple, MatchiePalette.red],
  );

  static const LinearGradient page = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF11122A), MatchiePalette.ink, MatchiePalette.ink],
  );

  static const LinearGradient warmPage = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF151020),
      MatchiePalette.ink,
      MatchiePalette.ink,
      Color(0xFF1D102D),
    ],
    stops: [0, 0.36, 0.78, 1],
  );

  static LinearGradient panelGlow = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.white.withValues(alpha: 0.20),
      MatchiePalette.purple.withValues(alpha: 0.16),
      MatchiePalette.cyan.withValues(alpha: 0.08),
      MatchiePalette.panel.withValues(alpha: 0.48),
    ],
  );
}

class MatchieStyle {
  const MatchieStyle._();

  static const double maxContentWidth = 520;
  static const double pagePadding = 15;
  static const double radius = 20;
  static const double compactRadius = 16;

  static LinearGradient glassGradient({bool active = false}) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.white.withValues(alpha: active ? 0.19 : 0.13),
        MatchiePalette.purple.withValues(alpha: active ? 0.18 : 0.08),
        MatchiePalette.cyan.withValues(alpha: active ? 0.08 : 0.04),
        MatchiePalette.panel.withValues(alpha: active ? 0.50 : 0.36),
      ],
      stops: const [0, 0.34, 0.64, 1],
    );
  }

  static Color glassBorder({bool active = false}) {
    return active
        ? Colors.white.withValues(alpha: 0.24)
        : Colors.white.withValues(alpha: 0.14);
  }

  static const TextStyle brandTitle = TextStyle(
    fontFamily: 'Playfair Display',
    color: MatchiePalette.text,
    fontSize: 30,
    height: 0.96,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    decoration: TextDecoration.none,
  );

  static const TextStyle brandSerifTitle = TextStyle(
    fontFamily: 'Playfair Display',
    color: MatchiePalette.text,
    fontSize: 30,
    height: 0.96,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    decoration: TextDecoration.none,
  );

  static const TextStyle brandHeading = TextStyle(
    fontFamily: 'Playfair Display',
    color: MatchiePalette.text,
    fontSize: 22,
    height: 1.1,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    decoration: TextDecoration.none,
  );

  static const TextStyle screenTitle = TextStyle(
    fontFamily: 'Space Grotesk',
    color: MatchiePalette.text,
    fontSize: 22,
    height: 1.14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    decoration: TextDecoration.none,
  );

  static BoxDecoration panel({bool active = false}) {
    return BoxDecoration(
      gradient: glassGradient(active: active),
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: glassBorder(active: active)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.30),
          blurRadius: 24,
          offset: const Offset(0, 14),
        ),
        BoxShadow(
          color: Colors.white.withValues(alpha: active ? 0.06 : 0.03),
          blurRadius: 1,
          offset: const Offset(0, 1),
        ),
      ],
    );
  }

  static BoxDecoration compactPanel({bool active = false}) {
    return BoxDecoration(
      gradient: glassGradient(active: active),
      borderRadius: BorderRadius.circular(compactRadius),
      border: Border.all(color: glassBorder(active: active)),
    );
  }
}

ThemeData buildMatchieTheme() {
  final base = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: MatchiePalette.ink,
    colorScheme: const ColorScheme.dark(
      primary: MatchiePalette.purple,
      secondary: MatchiePalette.pink,
      surface: MatchiePalette.panel,
      onSurface: MatchiePalette.text,
    ),
  );
  final textTheme = GoogleFonts.spaceGroteskTextTheme(base.textTheme).apply(
    bodyColor: MatchiePalette.text,
    displayColor: MatchiePalette.text,
    decoration: TextDecoration.none,
  );

  return base.copyWith(
    textTheme: textTheme,
    iconTheme: const IconThemeData(color: MatchiePalette.muted),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: MatchiePalette.text,
      elevation: 0,
      centerTitle: false,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: MatchiePalette.midnight.withValues(alpha: 0.46),
      indicatorColor: MatchiePalette.glass.withValues(alpha: 0.28),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        final selected = states.contains(WidgetState.selected);
        return TextStyle(
          color: selected ? MatchiePalette.text : MatchiePalette.faint,
          fontSize: 11,
          fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          letterSpacing: 0,
        );
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        final selected = states.contains(WidgetState.selected);
        return IconThemeData(
          color: selected ? MatchiePalette.text : MatchiePalette.faint,
          size: 24,
        );
      }),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: MatchiePalette.glassSoft,
      labelStyle: const TextStyle(color: MatchiePalette.muted),
      hintStyle: const TextStyle(color: MatchiePalette.faint),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(color: MatchieStyle.glassBorder()),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(color: MatchieStyle.glassBorder()),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(
          color: MatchiePalette.cyan.withValues(alpha: 0.78),
        ),
      ),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: MatchiePalette.purple,
      inactiveTrackColor: MatchiePalette.outline,
      thumbColor: MatchiePalette.text,
      overlayColor: MatchiePalette.purple.withValues(alpha: 0.18),
    ),
  );
}
