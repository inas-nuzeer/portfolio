import 'package:flutter/material.dart';
import 'package:inas_portfolio/Utils/Theme/app_theme.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobileScreen = constraints.maxWidth < 600;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Me',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.start,
            ),
            SizedBox(
              width: isMobileScreen ? screenHeight : screenWidth / .6,
              child: Text(
                "I am an experienced and detail-oriented UX/UI product designer dedicated to creating intuitive and impactful digital experiences. Over the years, I have honed my skills in user research, wireframing, prototyping, and visual design, always striving to balance user needs with business objectives. My passion lies in understanding how people interact with technology and crafting solutions that are both functional and aesthetically pleasing",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: 50),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: AppTheme.lightTheme.colorScheme.primary,
                    width: 3,
                  ),
                ),
              ),
              child: Text(
                "I am an experienced and detail-oriented UX/UI product designer dedicated to creating intuitive and impactful digital experiences. Over the years, I have honed my skills in user research, wireframing, prototyping, and visual design, always striving to balance user needs with business objectives. My passion lies in understanding how people interact with technology and crafting solutions that are both functional and aesthetically pleasing",
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
          ],
        );
      },
    );
  }
}
