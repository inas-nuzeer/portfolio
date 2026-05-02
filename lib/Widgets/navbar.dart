import 'package:flutter/material.dart';
import 'package:inas_portfolio/Widgets/glass_container.dart';

class NavBar extends StatefulWidget {
  final bool isMobile;
  const NavBar({super.key, this.isMobile = false});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    // final double screenHeight = MediaQuery.of(context).size.height;
    return GlassContainer(
      width: widget.isMobile ? screenWidth : screenWidth * .5,
      height: 25,
      borderRadius: widget.isMobile ? 0 : 100,
      blurStrength: 12,
      paddingValue: 10,

      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: widget.isMobile
              ? MainAxisAlignment.spaceEvenly
              : MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _navItem(Icons.home, 'Home', () {}),
            if (!widget.isMobile) const SizedBox(width: 10),
            _navItem(Icons.thunderstorm, 'About', () {}),
            if (!widget.isMobile) const SizedBox(width: 10),
            _navItem(Icons.sms_failed, 'Skills', () {}),
            if (!widget.isMobile) const SizedBox(width: 10),
            _navItem(Icons.explore, 'Experience', () {}),
            if (!widget.isMobile) const SizedBox(width: 10),
            _navItem(Icons.connect_without_contact, 'Referals', () {}),
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
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Icon(icon, size: 15, color: Colors.brown[900]),
          ),
          const SizedBox(width: 5),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              text,
              style: TextStyle(
                color: Colors.brown[900],
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
