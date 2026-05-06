// ignore_for_file: deprecated_member_use

import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:inas_portfolio/Utils/Theme/app_theme.dart';

class BottomNavBar extends StatefulWidget {
  final Function(int) scrollToSection;
  final int currentIndex;
  final double height;

  const BottomNavBar({
    super.key,
    required this.scrollToSection,
    required this.height,
    this.currentIndex = 0,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int _activeIndex;

  static const List<_NavItem> _items = [
    _NavItem(icon: Icons.home_rounded, label: 'Home'),
    _NavItem(icon: Icons.person_rounded, label: 'About'),
    _NavItem(icon: Icons.bolt_rounded, label: 'Skills'),
    _NavItem(icon: Icons.timeline_rounded, label: 'Experience'),
    _NavItem(icon: Icons.work_rounded, label: 'Projects'),
    _NavItem(icon: Icons.school_rounded, label: 'Education'),
  ];

  @override
  void initState() {
    super.initState();
    _activeIndex = widget.currentIndex;
  }

  @override
  void didUpdateWidget(covariant BottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Sync active index when parent scroll drives a change
    if (oldWidget.currentIndex != widget.currentIndex) {
      setState(() => _activeIndex = widget.currentIndex);
    }
  }

  void _onTap(int index) {
    setState(() => _activeIndex = index);
    widget.scrollToSection(index);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: widget.height,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.07),
            border: Border(
              top: BorderSide(color: Colors.white.withOpacity(0.12), width: 1),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                _items.length,
                (index) => _buildItem(index),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(int index) {
    final bool isActive = _activeIndex == index;
    final Color activeColor = AppTheme.lightTheme.colorScheme.primary;
    const Color inactiveColor = Colors.white54;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _onTap(index),
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
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
                _items[index].icon,
                size: 22,
                color: isActive ? activeColor : inactiveColor,
              ),
              const SizedBox(height: 3),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 250),
                style: TextStyle(
                  fontSize: isActive ? 10 : 9,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
                  color: isActive ? activeColor : inactiveColor,
                  letterSpacing: 0.3,
                ),
                child: Text(_items[index].label),
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
