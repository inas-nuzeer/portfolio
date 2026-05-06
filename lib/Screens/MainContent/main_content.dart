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
import 'package:inas_portfolio/Widgets/shimmer_section.dart';

class MainContent extends StatefulWidget {
  const MainContent({super.key});

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  late final List<WidgetBuilder> _sections;
  final ScrollController _scrollController = ScrollController();

  // One key per section — used to measure actual rendered offsets
  late final List<GlobalKey> _sectionKeys;

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
      (_) => const Experience(),
      (_) => const Project(),
      (_) => const Education(),
    ];
    _sectionKeys = List.generate(_sections.length, (_) => GlobalKey());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  // ── Returns the scroll offset of section [index] by reading its RenderBox ──
  double? _offsetOfSection(int index) {
    final ctx = _sectionKeys[index].currentContext;
    if (ctx == null) return null;
    final box = ctx.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return null;

    // Position relative to the scroll view's own render object
    final scrollBox =
        _scrollController.position.context.storageContext.findRenderObject()
            as RenderBox?;
    if (scrollBox == null) return null;

    final offset = box.localToGlobal(Offset.zero, ancestor: scrollBox);
    return _scrollController.offset + offset.dy;
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final double currentOffset = _scrollController.offset;
    final double viewport = _scrollController.position.viewportDimension;

    // Find which section's top is closest to (but not past) the viewport centre
    int best = 0;
    double bestDist = double.infinity;

    for (int i = 0; i < _sections.length; i++) {
      final sectionOffset = _offsetOfSection(i);
      if (sectionOffset == null) continue;

      // Distance from the section top to the current scroll position
      final double dist = (sectionOffset - currentOffset).abs();
      if (dist < bestDist) {
        bestDist = dist;
        best = i;
      }

      // Once we've passed the midpoint of the viewport, prefer the next section
      if (sectionOffset > currentOffset + viewport * 0.5) break;
    }

    if (best != _activeIndex) setState(() => _activeIndex = best);
  }

  void _scrollToSection(int index) {
    if (!_scrollController.hasClients) return;

    final offset = _offsetOfSection(index);
    if (offset != null) {
      // Scroll to the exact top of the section
      _scrollController.animateTo(
        offset.clamp(0.0, _scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    } else {
      // Section not built yet (lazy list) — fall back to estimated offset
      // using accumulated minHeights (screenHeight per section)
      final double screenHeight = _scrollController.position.viewportDimension;
      _scrollController.animateTo(
        (index * screenHeight).clamp(
          0.0,
          _scrollController.position.maxScrollExtent,
        ),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  Future<void> _onRefresh() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1800));
    if (mounted) setState(() => _isLoading = false);
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
                  controller: _scrollController,
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

                          // Wrap with a keyed container so we can measure offset
                          Widget child = _constrainedBox(section, screenHeight);

                          if (index != 0 && index != 2 && index != 4) {
                            child = GlassContainer(
                              width: screenWidth,
                              child: child,
                            );
                          }

                          return KeyedSubtree(
                            key: _sectionKeys[index],
                            child: child,
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
