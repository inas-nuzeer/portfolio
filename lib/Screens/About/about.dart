import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inas_portfolio/Utils/Theme/app_theme.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isMobileScreen = screenWidth < 600;
    final String role = 'Associate Software Developer';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * .1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight * .04),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'About Me',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: isMobileScreen ? screenHeight : screenWidth,
            child: Text(
              "I build software that focuses on performance, usability, and real-world impact. As a Software Engineering graduate, I specialize in developing cross-platform mobile applications and full-stack web solutions using Flutter and Laravel. My experience includes working on production-level projects, where I've handled everything from UI design and API integration to backend logic and database management. I pay close attention to writing clean, scalable code and creating smooth user experiences that make applications feel reliable and intuitive.",
              style: GoogleFonts.inter(
                fontSize: isMobileScreen ? 12 : 20,
                color: AppTheme.lightTheme.colorScheme.surface,
                height: isMobileScreen ? 1.2 : 1.5,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          const SizedBox(height: 50),
          Container(
            width: isMobileScreen ? screenWidth : screenWidth,
            padding: EdgeInsets.only(left: isMobileScreen ? 10 : 20),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: AppTheme.lightTheme.colorScheme.primary,
                  width: 3,
                ),
              ),
            ),
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.inter(
                  fontSize: isMobileScreen ? 13 : 24,
                  color: AppTheme.lightTheme.colorScheme.surface,
                  height: isMobileScreen ? 1.1 : 1.5,
                ),
                children: [
                  TextSpan(
                    text:
                        "I approach development with a problem-solving mindset—analyzing requirements, designing efficient solutions, and continuously refining my work to meet real-world needs. I'm always learning, always building, and always looking for ways to improve both technically and professionally. I'm currently seeking an ",
                    // textAlign: TextAlign.justify,
                  ),
                  TextSpan(
                    text: role,
                    style: GoogleFonts.inter(
                      fontSize: isMobileScreen ? 13 : 24,
                      color: AppTheme.lightTheme.colorScheme.primary,
                      height: isMobileScreen ? 1.1 : 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                    // textAlign: TextAlign.justify,
                  ),
                  TextSpan(
                    text:
                        " role where I can contribute to impactful products, collaborate with skilled teams, and grow into a highly capable engineer.",
                    // textAlign: TextAlign.justify,
                  ),
                ],
              ),
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
