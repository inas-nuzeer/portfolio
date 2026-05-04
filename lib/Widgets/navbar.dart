import 'package:flutter/material.dart';
import 'package:inas_portfolio/Utils/Theme/app_theme.dart';
import 'package:inas_portfolio/Widgets/glass_container.dart';

class NavBar extends StatefulWidget {
  final Function(int) scrollToSection;
  NavBar({super.key, required this.scrollToSection});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late bool isSelected;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobileScreen = screenWidth < 600;

    // final double screenHeight = MediaQuery.of(context).size.height;
    return GlassContainer(
      width: isMobileScreen ? screenWidth : screenWidth * .5,
      height: isMobileScreen ? 150 : 25,
      borderRadius: isMobileScreen ? 0 : 100,
      blurStrength: 12,
      paddingValue: isMobileScreen ? 0 : 10,
      isMobileScreen: isMobileScreen,

      child: Center(
        child: Row(
          mainAxisAlignment: isMobileScreen
              ? MainAxisAlignment.spaceEvenly
              : MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _navItem(Icons.home, 'Home', () => widget.scrollToSection(0)),
            if (!isMobileScreen) const SizedBox(width: 10),
            _navItem(
              Icons.thunderstorm,
              'About',
              () => widget.scrollToSection(1),
            ),
            if (!isMobileScreen) const SizedBox(width: 10),
            _navItem(
              Icons.sms_failed,
              'Skills',
              () => widget.scrollToSection(2),
            ),
            if (!isMobileScreen) const SizedBox(width: 10),
            _navItem(
              Icons.connect_without_contact,
              'Projects',
              () => widget.scrollToSection(3),
            ),
            if (!isMobileScreen) const SizedBox(width: 10),
            _navItem(
              Icons.explore,
              'Experience',
              () => widget.scrollToSection(4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 15, color: AppTheme.lightTheme.primaryColor),
          const SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
              color: AppTheme.lightTheme.primaryColor,
              // color: Colors.brown[900],
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
