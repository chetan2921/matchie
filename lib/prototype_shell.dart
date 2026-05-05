import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

import 'prototype_screens.dart';
import 'prototype_theme.dart';

class MatchieShell extends StatefulWidget {
  const MatchieShell({super.key});

  @override
  State<MatchieShell> createState() => _MatchieShellState();
}

class _MatchieShellState extends State<MatchieShell> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomeDashboardScreen(),
      ProfileHubScreen(onTabSelected: _selectTab),
      JobMatchesScreen(onTabSelected: _selectTab),
      MatchieAiHomeScreen(onTabSelected: _selectTab),
      MatchieOnTheGoOverviewScreen(onTabSelected: _selectTab),
      SupportScreen(onTabSelected: _selectTab),
      SettingsScreen(onTabSelected: _selectTab),
    ];

    return MatchieMenuScope(
      onTabSelected: _selectTab,
      child: Scaffold(
        extendBody: true,
        body: IndexedStack(index: _selectedIndex, children: screens),
        bottomNavigationBar: SafeArea(
          minimum: const EdgeInsets.fromLTRB(14, 0, 14, 12),
          child: MatchieFloatingNav(
            selectedIndex: _selectedIndex,
            onSelected: _selectTab,
          ),
        ),
        backgroundColor: MatchiePalette.ink,
      ),
    );
  }

  void _selectTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class MatchieFloatingNav extends StatelessWidget {
  const MatchieFloatingNav({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  static final _items = [
    _NavItem(label: 'Home', icon: FontAwesomeIcons.house),
    _NavItem(label: 'Profile', icon: FontAwesomeIcons.user),
    _NavItem(label: 'Jobs', icon: FontAwesomeIcons.briefcase),
    _NavItem(label: 'MatchieAI', icon: FontAwesomeIcons.commentDots),
    _NavItem(label: 'Matchie on the Go', icon: FontAwesomeIcons.locationDot),
    _NavItem(label: 'Support', icon: FontAwesomeIcons.circleQuestion),
    _NavItem(label: 'Settings', icon: FontAwesomeIcons.sliders),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final navWidth = constraints.maxWidth > 376
            ? 376.0
            : constraints.maxWidth;
        final buttonSize = ((navWidth - 28) / _items.length)
            .clamp(32.0, 39.0)
            .toDouble();

        return Center(
          heightFactor: 1,
          child: Container(
            width: navWidth,
            height: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(29),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.34),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(29),
              child: BackdropFilter(
                filter: MatchieStyle.glassBlur(active: true),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    gradient: MatchieStyle.glassGradient(active: true),
                    borderRadius: BorderRadius.circular(29),
                    border: Border.all(
                      color: MatchieStyle.glassBorder(active: true),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (var i = 0; i < _items.length; i++)
                        _NavButton(
                          item: _items[i],
                          selected: selectedIndex == i,
                          size: buttonSize,
                          onTap: () => onSelected(i),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _NavItem {
  const _NavItem({required this.label, required this.icon});

  final String label;
  final FaIconData icon;
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.item,
    required this.selected,
    required this.size,
    required this.onTap,
  });

  final _NavItem item;
  final bool selected;
  final double size;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final iconSize = (size * 0.50).clamp(17.0, 19.0).toDouble();

    return SizedBox(
      width: size,
      height: size,
      child: Semantics(
        button: true,
        selected: selected,
        label: item.label,
        child: Tooltip(
          message: item.label,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(99),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              decoration: BoxDecoration(
                color: selected
                    ? MatchiePalette.purple.withValues(alpha: 0.24)
                    : Colors.transparent,
                shape: BoxShape.circle,
                border: selected
                    ? Border.all(
                        color: MatchiePalette.purple.withValues(alpha: 0.36),
                      )
                    : null,
              ),
              child: Center(
                child: FaIcon(
                  item.icon,
                  color: selected ? MatchiePalette.text : MatchiePalette.faint,
                  size: iconSize,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
