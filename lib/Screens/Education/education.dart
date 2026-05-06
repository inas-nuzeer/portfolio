import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inas_portfolio/Utils/Theme/app_theme.dart';

class Education extends StatelessWidget {
  const Education({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isMobileScreen = screenWidth < 600;
    // final String role = 'Associate Software Developer';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * .1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight * .04),
          AutoSizeText(
            'Education & Achievements',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.start,
            maxLines: 2,
            minFontSize: 12, // Minimum font size before it scales down
            stepGranularity: 1, // How much to reduce font size by each step
            overflow:
                TextOverflow.clip, // Just clip instead of showing ellipsis
          ),
          const SizedBox(height: 40),
          _educationAndAchievements(
            'BSc. in Software Engineering',
            'National Textile University, Faisalabad, Pakistan',
            2020,
            2024,
            isMobileScreen,
          ),
          const SizedBox(height: 20),
          _educationAndAchievements(
            '3rd Position - Final Year Project Display',
            'Developed "Xplorit Rent With Ease", a rental mobile application for both lenders and renters at Department of Computer Science, National Textile University, Faisalabad',
            2024,
            2024,
            isMobileScreen,
          ),
          SizedBox(
            height: isMobileScreen ? screenHeight * .12 : screenHeight * .04,
          ),
        ],
      ),
    );
  }

  Widget _educationAndAchievements(
    String title,
    String text,
    int yearStart,
    int yearEnd,
    bool isMobileScreen,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Icon(
            Icons.circle,
            size: isMobileScreen ? 10 : 12,
            color: AppTheme.lightTheme.primaryColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                yearStart == yearEnd
                    ? (yearStart != 0 ? '$title - $yearStart' : title)
                    : (yearStart != 0
                          ? '$title ($yearStart - $yearEnd)'
                          : title), // 'title',
                style: GoogleFonts.poppins(
                  fontSize: isMobileScreen ? 20 : 28,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.lightTheme.secondaryHeaderColor,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                text,
                style: GoogleFonts.poppins(
                  fontSize: isMobileScreen ? 14 : 20,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.lightTheme.primaryColor,
                ),
                // Theme.of(context).textTheme.displaySmall,
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
