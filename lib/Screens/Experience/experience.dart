import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inas_portfolio/Utils/Theme/app_theme.dart';

class Experience extends StatelessWidget {
  const Experience({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isMobileScreen = screenWidth < 600;

    return SizedBox(
      height: screenHeight,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * .1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * .04),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Work Experience',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(height: 20),
            // ── Scrollable tab content ───────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    SizedBox(
                      width: screenWidth,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Icon(
                              Icons.circle,
                              size: 12,
                              color: AppTheme.lightTheme.primaryColor,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Flutter Developer Intern',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            // decoration: BoxDecoration(
                            //   border: Border(
                            //     left: BorderSide(
                            //       width: 2,
                            //       color: AppTheme.lightTheme.secondaryHeaderColor,
                            //     ),
                            //   ),
                            // ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    'Nova-Script Pvt Ltd | 6-Month Internship',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: AppTheme.lightTheme.primaryColor,
                                    ),
                                    // Theme.of(context).textTheme.displaySmall,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Text(
                                  'During my internship at Nova-Script Pvt Ltd, I worked as a Flutter Mobile App Developer, contributing to real-world production applications within a collaborative team environment.\n\n I was involved in developing a large-scale tourism and hostel booking application, “Book Now”, where I worked on core mobile features, responsive UI components, API integration, and overall user experience improvements. \n\n In addition to Flutter development, I contributed to multiple Laravel-based web applications, gaining hands-on experience in backend development, API creation, and database-driven systems. I also worked with Git and GitHub for version control, including branching, pull requests, and resolving merge conflicts during development.',
                                  style: GoogleFonts.inter(
                                    fontSize: isMobileScreen ? 12 : 20,
                                    color:
                                        AppTheme.lightTheme.colorScheme.surface,
                                    height: isMobileScreen ? 1.2 : 1.5,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                const SizedBox(height: 20),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    'Key Contributions:',
                                    style: GoogleFonts.poppins(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w500,
                                      color: AppTheme.lightTheme.primaryColor,
                                    ),
                                    // Theme.of(context).textTheme.displaySmall,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                _contributionRow(
                                  'Developed and maintained Flutter-based mobile application features for the “Book Now” platform',
                                  screenWidth,
                                  isMobileScreen,
                                ),
                                _contributionRow(
                                  'Implemented responsive UI components and improved user interaction flows',
                                  screenWidth,
                                  isMobileScreen,
                                ),
                                _contributionRow(
                                  'Integrated REST APIs for real-time data communication between mobile and backend systems',
                                  screenWidth,
                                  isMobileScreen,
                                ),
                                _contributionRow(
                                  'Worked on Laravel-based web applications, including CRUD systems and API endpoints',
                                  screenWidth,
                                  isMobileScreen,
                                ),
                                _contributionRow(
                                  'Participated in collaborative development using Git version control (branching, pull requests, conflict resolution)',
                                  screenWidth,
                                  isMobileScreen,
                                ),
                                _contributionRow(
                                  'Contributed to debugging, testing, and performance improvements across mobile and web applications',
                                  screenWidth,
                                  isMobileScreen,
                                ),
                                _contributionRow(
                                  'Gained hands-on experience working in a structured team environment following agile-like workflows',
                                  screenWidth,
                                  isMobileScreen,
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 0,
                            bottom: 0,
                            child: Container(
                              width: 1, // Border width
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.white, Colors.grey],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
      ),
    );
  }

  Widget _contributionRow(
    String text,
    double screenWidth,
    bool isMobileScreen,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '--',
          style: TextStyle(
            fontSize: isMobileScreen ? 12 : 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.lightTheme.colorScheme.primary,
            height: isMobileScreen ? 0.9 : 1.2,
          ),
        ),
        // Icon(Icons.circle, size: 8, color: AppTheme.lightTheme.primaryColor),
        const SizedBox(width: 10),
        Expanded(
          child: SizedBox(
            width: screenWidth,
            child: Text(
              '$text\n',
              style: GoogleFonts.inter(
                fontSize: isMobileScreen ? 12 : 18,
                color: AppTheme.lightTheme.colorScheme.surface,
                height: isMobileScreen ? 0.9 : 1.2,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ),
      ],
    );
  }
}
