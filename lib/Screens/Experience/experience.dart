import 'package:flutter/material.dart';

class Experience extends StatelessWidget {
  const Experience({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isMobileScreen = screenWidth < 600;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * .1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight * .04),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Experiences',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(
            height: isMobileScreen ? screenHeight * .12 : screenHeight * .04,
          ),
        ],
      ),
    );
  }
}
