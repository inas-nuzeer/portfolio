import 'package:flutter/material.dart';
import 'package:inas_portfolio/Widgets/project_card.dart';

class Project extends StatelessWidget {
  const Project({super.key});

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
              'Projects',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(height: screenHeight * .04),

          // Cards — stacked on mobile, side by side on desktop
          isMobileScreen
              ? Column(
                  children: [
                    _buildCard1(),
                    const SizedBox(height: 20),
                    _buildCard2(),
                  ],
                )
              : Row(
                  children: [
                    Expanded(child: _buildCard1()),
                    const SizedBox(width: 20),
                    Expanded(child: _buildCard2()),
                  ],
                ),

          SizedBox(
            height: isMobileScreen ? screenHeight * .12 : screenHeight * .04,
          ),
        ],
      ),
    );
  }

  Widget _buildCard1() {
    return ProjectCard(
      title: 'Portfolio App',
      subtitle: 'Personal portfolio built with Flutter Web',
      tags: const ['Flutter', 'Dart', 'Web'],
    );
  }

  Widget _buildCard2() {
    return ProjectCard(
      title: 'UI Design System',
      subtitle: 'Reusable component library for mobile apps',
      tags: const ['Figma', 'UX/UI', 'Mobile'],
    );
  }
}
