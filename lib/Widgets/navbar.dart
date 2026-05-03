import 'package:flutter/material.dart';
import 'package:inas_portfolio/Widgets/glass_container.dart';

class NavBar extends StatefulWidget {
  // final bool isMobile;
  const NavBar({
    super.key,
    //  this.isMobile = false
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobileScreen = screenWidth < 600;

    // final double screenHeight = MediaQuery.of(context).size.height;
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: GlassContainer(
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
              _navItem(Icons.home, 'Home', () {}),
              if (!isMobileScreen) const SizedBox(width: 10),
              _navItem(Icons.thunderstorm, 'About', () {}),
              if (!isMobileScreen) const SizedBox(width: 10),
              _navItem(Icons.sms_failed, 'Skills', () {}),
              if (!isMobileScreen) const SizedBox(width: 10),
              _navItem(Icons.explore, 'Experience', () {}),
              if (!isMobileScreen) const SizedBox(width: 10),
              _navItem(Icons.connect_without_contact, 'Referals', () {}),
            ],
          ),
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
          Icon(icon, size: 15, color: Colors.white),
          const SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
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
