import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
  late final List<GlobalKey> _sectionKeys;

  // Cached absolute scroll offsets for each section top.
  // Populated after layout and refreshed on scroll (lazy sections build late).
  final List<double?> _sectionOffsets = [];

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
    _sectionOffsets.addAll(List.filled(_sections.length, null));

    _scrollController.addListener(_onScroll);

    // Measure offsets after the first frame
    SchedulerBinding.instance.addPostFrameCallback((_) => _measureOffsets());
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  // ── Measure and cache the absolute scroll offset of every built section ──
  void _measureOffsets() {
    if (!_scrollController.hasClients) return;

    final scrollBox =
        _scrollController.position.context.storageContext.findRenderObject()
            as RenderBox?;
    if (scrollBox == null) return;

    for (int i = 0; i < _sections.length; i++) {
      final ctx = _sectionKeys[i].currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null || !box.hasSize) continue;

      final localOffset = box.localToGlobal(Offset.zero, ancestor: scrollBox);
      _sectionOffsets[i] = _scrollController.offset + localOffset.dy;
    }
  }

  // ── Returns cached offset, re-measuring if not yet available ──
  double? _offsetOfSection(int index) {
    if (_sectionOffsets[index] == null) _measureOffsets();
    return _sectionOffsets[index];
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    // Re-measure on every scroll tick so newly-built lazy sections get cached
    _measureOffsets();
    final double currentOffset = _scrollController.offset;

    // Active = last section whose top is at or above the current scroll offset
    int active = 0;
    for (int i = 0; i < _sections.length; i++) {
      final top = _sectionOffsets[i];
      if (top == null) continue;
      if (top <= currentOffset + 1) {
        active = i;
      } else {
        break;
      }
    }

    if (active != _activeIndex) setState(() => _activeIndex = active);
  }

  void _scrollToSection(int index) {
    if (!_scrollController.hasClients) return;

    // Re-measure before scrolling — sections may have been built since last tick
    _measureOffsets();

    final double? offset = _sectionOffsets[index];

    if (offset != null) {
      _scrollController.animateTo(
        offset.clamp(0.0, _scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    } else {
      // Section not built yet — scroll far enough to trigger its build,
      // then scroll again once it's laid out.
      final double estimated =
          _scrollController.position.maxScrollExtent *
          index /
          (_sections.length - 1);

      _scrollController
          .animateTo(
            estimated.clamp(0.0, _scrollController.position.maxScrollExtent),
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeIn,
          )
          .then((_) {
            // After the scroll settles, sections should be built — measure and scroll precisely
            SchedulerBinding.instance.addPostFrameCallback((_) {
              _measureOffsets();
              final double? precise = _sectionOffsets[index];
              if (precise != null && _scrollController.hasClients) {
                _scrollController.animateTo(
                  precise.clamp(
                    0.0,
                    _scrollController.position.maxScrollExtent,
                  ),
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOutCubic,
                );
              }
            });
          });
    }
  }

  Future<void> _onRefresh() async {
    setState(() => _isLoading = true);
    // Reset cached offsets so they're re-measured after shimmer → real content swap
    _sectionOffsets.fillRange(0, _sectionOffsets.length, null);
    await Future.delayed(const Duration(milliseconds: 1800));
    if (mounted) {
      setState(() => _isLoading = false);
      SchedulerBinding.instance.addPostFrameCallback((_) => _measureOffsets());
    }
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
                          Widget child = _constrainedBox(section, screenHeight);

                          // Alternate glass / no-glass per section
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
                        // Keep all sections alive so GlobalKeys stay valid
                        addAutomaticKeepAlives: true,
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
