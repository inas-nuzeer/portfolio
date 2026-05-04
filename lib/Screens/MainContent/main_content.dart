import 'package:flutter/material.dart';
import 'package:inas_portfolio/Screens/About/about.dart';
import 'package:inas_portfolio/Screens/Experience/experience.dart';
import 'package:inas_portfolio/Screens/Home/home.dart';
import 'package:inas_portfolio/Screens/Projects/project.dart';
import 'package:inas_portfolio/Screens/Skills/skills.dart';
import 'package:inas_portfolio/Widgets/glass_container.dart';
import 'package:inas_portfolio/Widgets/navbar.dart';
import 'package:inas_portfolio/Widgets/shimmer_section.dart';

class MainContent extends StatefulWidget {
  const MainContent({super.key});

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  bool _isHovering = false;
  bool _isLoading = false;

  late final List<WidgetBuilder> _sections;

  @override
  void initState() {
    super.initState();
    _sections = [
      (_) => const Home(),
      (_) => const About(),
      (_) => const Project(),
      (_) => const Skill(),
      (_) => const Experience(),
    ];
  }

  Future<void> _onRefresh() async {
    setState(() => _isLoading = true);

    // Simulate a network/data reload — replace with real async work if needed
    await Future.delayed(const Duration(milliseconds: 1800));

    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isMobileScreen = screenWidth < 600;

    return Scaffold(
      backgroundColor: Colors.black,
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: isMobileScreen
                ? const AssetImage('assets/images/bg_image_mobile.png')
                : const AssetImage('assets/images/bg_image.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // ── Scrollable content ─────────────────────────────────────
              RefreshIndicator(
                onRefresh: _onRefresh,
                color: const Color(0xFFfeb800),
                backgroundColor: Colors.black87,
                strokeWidth: 2.5,
                child: CustomScrollView(
                  // Ensures pull-to-refresh works even when content fills screen
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          // ── Shimmer state ──────────────────────────────
                          if (_isLoading) {
                            return ShimmerSection(
                              height: screenHeight,
                              hasGlass: index != 0,
                            );
                          }

                          // ── Real content ───────────────────────────────
                          final Widget section = _sections[index](context);

                          if (index == 0) {
                            return _constrainedBox(section, screenHeight);
                          }

                          return GlassContainer(
                            width: screenWidth,
                            child: _constrainedBox(section, screenHeight),
                          );
                        },
                        childCount: _sections.length,
                        addAutomaticKeepAlives: false,
                        addRepaintBoundaries: true,
                      ),
                    ),
                  ],
                ),
              ),

              // ── Download CV button ─────────────────────────────────────
              Positioned(
                top: screenHeight * .04,
                right: screenWidth * .1,
                child: SizedBox(
                  height: 35,
                  width: 130,
                  child: _buildDownloadButton(),
                ),
              ),

              // ── Navbar ─────────────────────────────────────────────────
              Positioned(
                bottom: isMobileScreen ? 0 : screenHeight * .04,
                right: isMobileScreen ? 0 : screenWidth * .28,
                left: isMobileScreen ? 0 : screenWidth * .28,
                child: const Center(child: NavBar()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDownloadButton() {
    return GlassContainer(
      width: 130,
      height: 40,
      borderRadius: 100,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovering = true),
        onExit: (_) => setState(() => _isHovering = false),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFfeb800),
            padding: EdgeInsets.zero,
          ),
          child: Center(
            child: _isHovering
                ? const Icon(Icons.download, size: 18, color: Colors.black)
                : const Text(
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
