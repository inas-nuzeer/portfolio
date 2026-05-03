import 'package:flutter/material.dart';
import 'package:inas_portfolio/Screens/About/about.dart';
import 'package:inas_portfolio/Screens/Home/home.dart';
import 'package:inas_portfolio/Screens/Projects/project.dart';
import 'package:inas_portfolio/Screens/Skills/skills.dart';
import 'package:inas_portfolio/Widgets/glass_container.dart';
import 'package:inas_portfolio/Widgets/navbar.dart';

class MainContent extends StatefulWidget {
  const MainContent({super.key});

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_image.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobileScreen = constraints.maxWidth < 600;
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * .0,
                  // vertical: screenHeight * .05,
                ),
                child: Stack(
                  children: [
                    // Make Column take full available space
                    Column(
                      children: [
                        // If Need a Fixed section
                        // Scrollable content - Use Expanded here
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                _constrainedBox(Home(), screenHeight),
                                _constrainedBox(About(), screenHeight),
                                _constrainedBox(Project(), screenHeight),
                                _constrainedBox(Skill(), screenHeight),
                                _constrainedBox(Project(), screenHeight),
                                // Add more content here to make it scrollable
                                // const SizedBox(height: 500), // Extra content for demo
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: screenHeight * .04,
                      right: screenWidth * .1,
                      child: SizedBox(
                        height: 35,
                        width: 130,
                        child: _buildDownloadButton(),
                      ),
                    ),
                    // Navbar at bottom
                    if (!isMobileScreen) ...[
                      Positioned(
                        bottom: isMobileScreen ? 0 : screenHeight * .04,
                        right: isMobileScreen ? 0 : screenWidth * .28,
                        left: isMobileScreen ? 0 : screenWidth * .28,
                        // right: 0,
                        child: Center(child: NavBar(isMobile: isMobileScreen)),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
      // bottomNavigationBar: SizedBox(
      //   // padding: EdgeInsets.all(25),
      //   height: 150,
      //   child: NavBar(isMobile: true),
      // ),
    );
  }

  Widget _buildDownloadButton() {
    return GlassContainer(
      width: 130,
      height: 40,
      borderRadius: 100,
      child: MouseRegion(
        onEnter: (_) => setState(() {
          _isHovering = true;
        }),
        onExit: (_) => setState(() {
          _isHovering = false;
        }),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFfeb800),
            padding: EdgeInsets.zero,
          ),
          child: Center(
            child: _isHovering
                ? Icon(Icons.download, size: 18, color: Colors.black)
                : Text(
                    'Download CV',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _constrainedBox(Widget child, double minHeight) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: minHeight),
      child: child,
    );
  }
}
