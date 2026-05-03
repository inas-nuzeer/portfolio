import 'package:flutter/material.dart';

class Skill extends StatelessWidget {
  const Skill({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * .1),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobileScreen = constraints.maxWidth < 600;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * .04),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'Skills',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
