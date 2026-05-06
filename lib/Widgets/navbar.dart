// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:inas_portfolio/Utils/Theme/app_theme.dart';
import 'package:inas_portfolio/Widgets/glass_container.dart';

class NavBar extends StatelessWidget {
  final Function(int) scrollToSection;
  final int activeIndex;

  const NavBar({
    super.key,
    required this.scrollToSection,
    this.activeIndex = 0,
  });

  static const List<_NavItem> _items = [
    _NavItem(icon: Icons.home_rounded, label: 'Home'),
    _NavItem(icon: Icons.person_rounded, label: 'About'),
    _NavItem(icon: Icons.bolt_rounded, label: 'Skills'),
    _NavItem(icon: Icons.timeline_rounded, label: 'Experience'),
    _NavItem(icon: Icons.work_rounded, label: 'Projects'),
    _NavItem(icon: Icons.school_rounded, label: 'Education'),
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return GlassContainer(
      width: screenWidth * .5,
      height: 60,
      borderRadius: 100,
      blurStrength: 12,
      paddingValue: 10,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(_items.length, (index) {
            final bool isLast = index == _items.length - 1;
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _NavButton(
                  item: _items[index],
                  isActive: activeIndex == index,
                  onTap: () => scrollToSection(index),
                ),
                if (!isLast) const SizedBox(width: 4),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final _NavItem item;
  final bool isActive;
  final VoidCallback onTap;

  const _NavButton({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color activeColor = AppTheme.lightTheme.colorScheme.primary;
    const Color inactiveColor = Colors.white54;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: isActive
                ? activeColor.withOpacity(0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Active dot indicator
              // AnimatedContainer(
              //   duration: const Duration(milliseconds: 250),
              //   width: isActive ? 4 : 0,
              //   height: isActive ? 4 : 0,
              //   margin: const EdgeInsets.only(bottom: 3),
              //   decoration: BoxDecoration(
              //     color: activeColor,
              //     shape: BoxShape.circle,
              //   ),
              // ),
              Icon(
                item.icon,
                size: 18,
                color: isActive ? activeColor : inactiveColor,
              ),
              const SizedBox(width: 2),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 250),
                style: TextStyle(
                  fontSize: isActive ? 15 : 14,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
                  color: isActive ? activeColor : inactiveColor,
                  letterSpacing: 0.3,
                ),
                child: Text(item.label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}
