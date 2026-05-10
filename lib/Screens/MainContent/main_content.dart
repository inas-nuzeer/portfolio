import 'package:flutter/material.dart';
import 'package:inas_portfolio/Screens/About/about.dart';
import 'package:inas_portfolio/Screens/Education/education.dart';
import 'package:inas_portfolio/Screens/Experience/experience.dart';
import 'package:inas_portfolio/Screens/Home/home.dart';
import 'package:inas_portfolio/Screens/Projects/project.dart';
import 'package:inas_portfolio/Screens/Skills/skills.dart';
import 'package:inas_portfolio/Utils/cv_downloader.dart';
import 'package:inas_portfolio/Widgets/bottom_nav_bar.dart';
import 'package:inas_portfolio/Widgets/glass_container.dart';
import 'package:inas_portfolio/Widgets/navbar.dart';

class MainContent extends StatefulWidget {
  const MainContent({super.key});

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  final ScrollController _scrollController = ScrollController();

  bool _isHovering = false;
  bool _isDownloading = false;
  int _activeIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final double offset = _scrollController.offset;
    final double sectionHeight = _scrollController.position.viewportDimension;

    final int index = (offset / sectionHeight).round().clamp(0, 5);

    if (index != _activeIndex) setState(() => _activeIndex = index);
  }

  void _scrollToSection(int index) {
    if (!_scrollController.hasClients) return;

    final double screenHeight = _scrollController.position.viewportDimension;
    final double targetOffset = index * screenHeight;
    final double maxOffset = _scrollController.position.maxScrollExtent;

    _scrollController.animateTo(
      targetOffset.clamp(0.0, maxOffset),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 800));
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isMobileScreen = screenWidth < 600;
    final bool isTabScreen = screenWidth < 1000 && screenWidth > 600;

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
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      _constrainedBox(const Home(), screenHeight),
                      GlassContainer(
                        width: screenWidth,
                        child: _constrainedBox(const About(), screenHeight),
                      ),
                      _constrainedBox(const Skill(), screenHeight),
                      GlassContainer(
                        width: screenWidth,
                        child: _constrainedBox(
                          const Experience(),
                          screenHeight,
                        ),
                      ),
                      _constrainedBox(
                        const Project(),
                        isMobileScreen ? screenHeight * .75 : screenHeight,
                      ),
                      GlassContainer(
                        width: screenWidth,
                        child: _constrainedBox(const Education(), screenHeight),
                      ),
                    ],
                  ),
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

              // ── Navbar (desktop) / BottomNavBar (mobile) ───────────────
              if (isMobileScreen || isTabScreen)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: BottomNavBar(
                    scrollToSection: _scrollToSection,
                    height: screenHeight * .1,
                    currentIndex: _activeIndex,
                  ),
                )
              else
                Positioned(
                  bottom: screenHeight * .04,
                  right: screenWidth * .20,
                  left: screenWidth * .20,
                  child: Center(
                    child: NavBar(
                      scrollToSection: _scrollToSection,
                      activeIndex: _activeIndex,
                    ),
                  ),
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
          onPressed: _isDownloading
              ? null
              : () async {
                  setState(() => _isDownloading = true);
                  try {
                    await downloadCv();
                  } finally {
                    if (mounted) setState(() => _isDownloading = false);
                  }
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFfeb800),
            disabledBackgroundColor: const Color(0xFFfeb800),
            padding: EdgeInsets.zero,
          ),
          child: Center(
            child: _isDownloading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.black,
                    ),
                  )
                : _isHovering
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
