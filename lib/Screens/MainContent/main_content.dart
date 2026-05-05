import 'package:flutter/material.dart';
import 'package:inas_portfolio/Screens/About/about.dart';
import 'package:inas_portfolio/Screens/Experience/experience.dart';
import 'package:inas_portfolio/Screens/Home/home.dart';
import 'package:inas_portfolio/Screens/Projects/project.dart';
import 'package:inas_portfolio/Screens/Skills/skills.dart';
import 'package:inas_portfolio/Utils/cv_downloader.dart';
import 'package:inas_portfolio/Widgets/bottom_nav_bar.dart';
import 'package:inas_portfolio/Widgets/glass_container.dart';
import 'package:inas_portfolio/Widgets/navbar.dart';
import 'package:inas_portfolio/Widgets/shimmer_section.dart';

class MainContent extends StatefulWidget {
  const MainContent({super.key});

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  late final List<WidgetBuilder> _sections;
  final ScrollController _scrollController = ScrollController();

  bool _isHovering = false;
  bool _isLoading = false;
  int _activeIndex = 0;

  @override
  void initState() {
    super.initState();
    _sections = [
      (_) => const Home(),
      (_) => const About(),
      (_) => const Skill(),
      (_) => const Project(),
      (_) => const Experience(),
    ];
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final double offset = _scrollController.offset;
    final double sectionHeight = _scrollController.position.viewportDimension;

    // Which section occupies the majority of the viewport right now
    final int index = (offset / sectionHeight).round().clamp(
      0,
      _sections.length - 1,
    );

    if (index != _activeIndex) {
      setState(() => _activeIndex = index);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1800));
    if (mounted) setState(() => _isLoading = false);
  }

  /// Each section has a minHeight of [screenHeight], so the scroll offset
  /// for section [index] is simply index * screenHeight.
  /// This is reliable regardless of scroll position or build state.
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
                child: CustomScrollView(
                  controller: _scrollController, // ✅ FIX 1: Add the controller
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          if (_isLoading) {
                            return ShimmerSection(
                              height: screenHeight,
                              hasGlass: index != 0,
                            );
                          }

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
                  right: screenWidth * .28,
                  left: screenWidth * .28,
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
          onPressed: () => downloadCv(),
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
