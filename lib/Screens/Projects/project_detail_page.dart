// ignore_for_file: deprecated_member_use

import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inas_portfolio/Widgets/video_player_widget.dart';
import 'package:url_launcher/url_launcher.dart';

// ── Media item model ──────────────────────────────────────────────────────────

enum MediaType { image, video }

class ProjectMediaItem {
  final String src;
  final MediaType type;
  final String? caption;

  const ProjectMediaItem.image(this.src, {this.caption})
    : type = MediaType.image;

  const ProjectMediaItem.video(this.src, {this.caption})
    : type = MediaType.video;
}

// ── Page ──────────────────────────────────────────────────────────────────────

class ProjectDetailPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String role;
  final String description;
  final List<String> tags;
  final String? liveUrl;
  final String? githubUrl;
  final List<ProjectMediaItem> mediaItems;
  final List<String> myRole;
  final List<String> keyContributions;
  final List<String> skillsDemonstrated;
  final Map<String, List<String>> techStack;
  final List<String> keyFeatures;

  const ProjectDetailPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    this.role = '',
    this.tags = const [],
    this.liveUrl,
    this.githubUrl,
    this.mediaItems = const [],
    this.myRole = const [],
    this.keyContributions = const [],
    this.skillsDemonstrated = const [],
    this.techStack = const {},
    this.keyFeatures = const [],
  });

  static void push(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String description,
    String role = '',
    List<String> tags = const [],
    String? liveUrl,
    String? githubUrl,
    List<ProjectMediaItem> mediaItems = const [],
    List<String> myRole = const [],
    List<String> keyContributions = const [],
    List<String> skillsDemonstrated = const [],
    Map<String, List<String>> techStack = const {},
    List<String> keyFeatures = const [],
  }) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        reverseTransitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) =>
            ProjectDetailPage(
              title: title,
              subtitle: subtitle,
              role: role,
              description: description,
              tags: tags,
              liveUrl: liveUrl,
              githubUrl: githubUrl,
              mediaItems: mediaItems,
              myRole: myRole,
              keyContributions: keyContributions,
              skillsDemonstrated: skillsDemonstrated,
              techStack: techStack,
              keyFeatures: keyFeatures,
            ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              ),
              child: child,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isMobile = screenWidth < 600;

    return Scaffold(
      backgroundColor: Colors.black,
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/bg_image2.png'),
            //  isMobile
            //     ? const AssetImage('assets/images/bg_image_mobile.png')
            //     : const AssetImage('assets/images/bg_image.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? screenWidth * 0.06 : screenWidth * 0.12,
              vertical: 32,
            ),
            children: [
              const _BackButton(),
              SizedBox(height: screenHeight * 0.05),

              // ── Hero + Media (desktop: two-column; mobile: stacked) ──
              if (isMobile) ...[
                _HeroSection(
                  title: title,
                  subtitle: subtitle,
                  role: role,
                  liveUrl: liveUrl,
                  githubUrl: githubUrl,
                  isMobile: true,
                ),
                if (mediaItems.isNotEmpty) ...[
                  SizedBox(height: screenHeight * 0.04),
                  const _SectionLabel(label: 'Screenshots & Videos'),
                  const SizedBox(height: 16),
                  _MediaCarousel(items: mediaItems, isMobile: true),
                ],
                SizedBox(height: screenHeight * 0.04),
              ] else ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left: hero info + media carousel
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _HeroSection(
                            title: title,
                            subtitle: subtitle,
                            role: role,
                            liveUrl: liveUrl,
                            githubUrl: githubUrl,
                            isMobile: false,
                          ),
                          if (mediaItems.isNotEmpty) ...[
                            SizedBox(height: screenHeight * 0.04),
                            const _SectionLabel(label: 'Screenshots & Videos'),
                            const SizedBox(height: 16),
                            _MediaCarousel(items: mediaItems, isMobile: false),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(width: 60),
                    // Right: tech stack
                    Expanded(
                      flex: 2,
                      child: techStack.isNotEmpty
                          ? _TechStackCard(techStack: techStack)
                          : tags.isNotEmpty
                          ? _TagsCard(tags: tags)
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.06),
              ],

              // ── Overview ─────────────────────────────────────────────
              const _SectionLabel(label: 'Overview'),
              const SizedBox(height: 16),
              _GlassCard(
                child: Text(
                  description,
                  style: GoogleFonts.inter(
                    fontSize: isMobile ? 15 : 17,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withOpacity(0.8),
                    height: 1.8,
                  ),
                ),
              ),

              // ── Tech Stack (mobile only — desktop shows in hero row) ─
              if (isMobile && techStack.isNotEmpty) ...[
                SizedBox(height: screenHeight * 0.04),
                const _SectionLabel(label: 'Tech Stack'),
                const SizedBox(height: 16),
                _TechStackCard(techStack: techStack),
              ] else if (isMobile && tags.isNotEmpty) ...[
                SizedBox(height: screenHeight * 0.04),
                const _SectionLabel(label: 'Tech Stack'),
                const SizedBox(height: 16),
                _TagsCard(tags: tags),
              ],

              // ── Key Features ─────────────────────────────────────────
              if (keyFeatures.isNotEmpty) ...[
                SizedBox(height: screenHeight * 0.04),
                const _SectionLabel(label: 'Key Features'),
                const SizedBox(height: 16),
                _GlassCard(
                  child: _TwoColumnBulletList(
                    items: keyFeatures,
                    isMobile: isMobile,
                  ),
                ),
              ],

              // ── My Role ──────────────────────────────────────────────
              if (myRole.isNotEmpty) ...[
                SizedBox(height: screenHeight * 0.04),
                const _SectionLabel(label: 'My Role'),
                const SizedBox(height: 16),
                _GlassCard(
                  child: _BulletList(items: myRole, isMobile: isMobile),
                ),
              ],

              // ── Key Contributions ────────────────────────────────────
              if (keyContributions.isNotEmpty) ...[
                SizedBox(height: screenHeight * 0.04),
                const _SectionLabel(label: 'Key Contributions'),
                const SizedBox(height: 16),
                _GlassCard(
                  child: _BulletList(
                    items: keyContributions,
                    isMobile: isMobile,
                    accentBullet: true,
                  ),
                ),
              ],

              // ── Skills Demonstrated ──────────────────────────────────
              if (skillsDemonstrated.isNotEmpty) ...[
                SizedBox(height: screenHeight * 0.04),
                const _SectionLabel(label: 'Skills Demonstrated'),
                const SizedBox(height: 16),
                _GlassCard(
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: skillsDemonstrated
                        .map((s) => _SkillPill(label: s))
                        .toList(),
                  ),
                ),
              ],

              SizedBox(height: screenHeight * 0.08),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Media carousel ────────────────────────────────────────────────────────────

class _MediaCarousel extends StatefulWidget {
  final List<ProjectMediaItem> items;
  final bool isMobile;
  const _MediaCarousel({required this.items, required this.isMobile});

  @override
  State<_MediaCarousel> createState() => _MediaCarouselState();
}

class _MediaCarouselState extends State<_MediaCarousel> {
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goTo(int index) {
    if (index < 0 || index >= widget.items.length) return;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool hasCaption =
        widget.items[_currentIndex].caption?.isNotEmpty == true;
    final bool currentIsVideo =
        widget.items[_currentIndex].type == MediaType.video;

    // Videos need a fixed height; images size to their natural aspect ratio.
    // On desktop the carousel sits in a constrained column so we keep a fixed
    // height there too — only on mobile do we let images be natural height.
    final double? fixedHeight = currentIsVideo || !widget.isMobile
        ? (widget.isMobile ? screenWidth * 0.75 : screenWidth * 0.45 * 0.5)
        : null; // null → wrap to image height on mobile

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: fixedHeight,
          width: widget.isMobile ? double.infinity : screenWidth * .35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.06),
            border: Border.all(color: Colors.white.withOpacity(0.12), width: 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Slide area ─────────────────────────────────────────────
              if (fixedHeight != null)
                // Fixed height mode (video or desktop): PageView fills space
                Expanded(child: _slideStack())
              else
                // Natural height mode (image on mobile): stack sizes to image
                _slideStack(),

              // ── Caption + dots ─────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (hasCaption) ...[
                      Text(
                        widget.items[_currentIndex].caption!,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.55),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                    _DotIndicator(
                      count: widget.items.length,
                      current: _currentIndex,
                      onDotTap: _goTo,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _slideStack() {
    final bool fixedMode =
        widget.items[_currentIndex].type == MediaType.video || !widget.isMobile;

    // In fixed mode PageView fills the Expanded parent.
    // In natural mode we show only the current slide (no PageView scroll)
    // because PageView requires a fixed height.
    if (fixedMode) {
      return PageView.builder(
        controller: _pageController,
        itemCount: widget.items.length,
        onPageChanged: (i) => setState(() => _currentIndex = i),
        itemBuilder: (_, i) => _MediaSlide(item: widget.items[i]),
      );
    }

    // Natural-height mode: show current image + overlay arrows/badge.
    // Swipe is handled by a GestureDetector since PageView needs fixed height.
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity == null) return;
        if (details.primaryVelocity! < -200) _goTo(_currentIndex + 1);
        if (details.primaryVelocity! > 200) _goTo(_currentIndex - 1);
      },
      child: Stack(
        children: [
          _MediaSlide(item: widget.items[_currentIndex]),
          if (_currentIndex > 0)
            Positioned(
              left: 12,
              top: 0,
              bottom: 0,
              child: Center(
                child: _ArrowButton(
                  icon: Icons.chevron_left_rounded,
                  onTap: () => _goTo(_currentIndex - 1),
                ),
              ),
            ),
          if (_currentIndex < widget.items.length - 1)
            Positioned(
              right: 12,
              top: 0,
              bottom: 0,
              child: Center(
                child: _ArrowButton(
                  icon: Icons.chevron_right_rounded,
                  onTap: () => _goTo(_currentIndex + 1),
                ),
              ),
            ),
          Positioned(
            top: 12,
            right: 12,
            child: _MediaBadge(type: widget.items[_currentIndex].type),
          ),
        ],
      ),
    );
  }
}

// ── Slides ────────────────────────────────────────────────────────────────────

class _MediaSlide extends StatelessWidget {
  final ProjectMediaItem item;
  const _MediaSlide({required this.item});

  @override
  Widget build(BuildContext context) => item.type == MediaType.image
      ? _ImageSlide(src: item.src)
      : _VideoSlide(src: item.src);
}

class _ImageSlide extends StatelessWidget {
  final String src;
  const _ImageSlide({required this.src});

  bool get _isNetwork => src.startsWith('http');

  @override
  Widget build(BuildContext context) {
    // fit: BoxFit.fitWidth — fills the full width and sizes height naturally.
    // No explicit height so the container wraps to the image's aspect ratio.
    return _isNetwork
        ? Image.network(
            src,
            fit: BoxFit.fitWidth,
            width: double.infinity,
            errorBuilder: (_, _, _) => const _ErrorPlaceholder(),
          )
        : Image.asset(
            src,
            fit: BoxFit.fitWidth,
            width: double.infinity,
            errorBuilder: (_, _, _) => const _ErrorPlaceholder(),
          );
  }
}

/// Video slide that shows the video player inline in the carousel.
/// On mobile, HtmlElementView can have positioning issues inside scrollable
/// containers, but we show it anyway. User can tap the expand button to view
/// fullscreen if needed.
class _VideoSlide extends StatelessWidget {
  final String src;
  const _VideoSlide({required this.src});

  // void _openFullscreen(BuildContext context) {
  //   showDialog<void>(
  //     context: context,
  //     barrierColor: Colors.black.withOpacity(0.92),
  //     builder: (_) => _FullscreenVideoDialog(src: src),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ── Video player ─────────────────────────────────────────────────
        VideoPlayerWidget(src: src),

        // ── Expand button (top-left) ─────────────────────────────────────
        // Positioned(
        //   top: 8,
        //   left: 8,
        //   child: GestureDetector(
        //     onTap: () => _openFullscreen(context),
        //     child: Container(
        //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(8),
        //         color: Colors.black.withOpacity(0.6),
        //         border: Border.all(color: Colors.white.withOpacity(0.2)),
        //       ),
        //       child: Row(
        //         mainAxisSize: MainAxisSize.min,
        //         children: [
        //           Icon(
        //             Icons.fullscreen_rounded,
        //             size: 14,
        //             color: Colors.white.withOpacity(0.9),
        //           ),
        //           const SizedBox(width: 4),
        //           Text(
        //             'Expand',
        //             style: GoogleFonts.inter(
        //               fontSize: 11,
        //               fontWeight: FontWeight.w500,
        //               color: Colors.white.withOpacity(0.9),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

/// Full-screen dialog that hosts the video player for better viewing.
// class _FullscreenVideoDialog extends StatelessWidget {
//   final String src;
//   const _FullscreenVideoDialog({required this.src});

//   @override
//   Widget build(BuildContext context) {
//     return Dialog.fullscreen(
//       backgroundColor: Colors.black,
//       child: Stack(
//         children: [
//           // ── Video player fills the screen ──────────────────────────────
//           Center(child: VideoPlayerWidget(src: src)),

//           // ── Close button ───────────────────────────────────────────────
//           Positioned(
//             top: 16,
//             right: 16,
//             child: SafeArea(
//               child: GestureDetector(
//                 onTap: () => Navigator.of(context).pop(),
//                 child: Container(
//                   width: 40,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.white.withOpacity(0.15),
//                     border: Border.all(color: Colors.white.withOpacity(0.25)),
//                   ),
//                   child: Icon(
//                     Icons.close_rounded,
//                     color: Colors.white.withOpacity(0.9),
//                     size: 20,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class _ErrorPlaceholder extends StatelessWidget {
  const _ErrorPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.04),
      child: Center(
        child: Icon(
          Icons.broken_image_rounded,
          color: Colors.white.withOpacity(0.2),
          size: 48,
        ),
      ),
    );
  }
}

// ── Arrow button ──────────────────────────────────────────────────────────────

class _ArrowButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _ArrowButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black.withOpacity(0.45),
            border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
          ),
          child: Icon(icon, color: Colors.white, size: 22),
        ),
      ),
    );
  }
}

// ── Media badge ───────────────────────────────────────────────────────────────

class _MediaBadge extends StatelessWidget {
  final MediaType type;
  const _MediaBadge({required this.type});

  @override
  Widget build(BuildContext context) {
    final bool isVideo = type == MediaType.video;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black.withOpacity(0.5),
        border: Border.all(color: Colors.white.withOpacity(0.15), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isVideo ? Icons.videocam_rounded : Icons.image_rounded,
            size: 12,
            color: isVideo
                ? const Color(0xFFfeb800)
                : Colors.white.withOpacity(0.7),
          ),
          const SizedBox(width: 4),
          Text(
            isVideo ? 'Video' : 'Image',
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isVideo
                  ? const Color(0xFFfeb800)
                  : Colors.white.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Dot indicator ─────────────────────────────────────────────────────────────

class _DotIndicator extends StatelessWidget {
  final int count;
  final int current;
  final void Function(int) onDotTap;
  const _DotIndicator({
    required this.count,
    required this.current,
    required this.onDotTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final bool active = i == current;
        return GestureDetector(
          onTap: () => onDotTap(i),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: active ? 20 : 6,
              height: 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: active
                    ? const Color(0xFFfeb800)
                    : Colors.white.withOpacity(0.25),
              ),
            ),
          ),
        );
      }),
    );
  }
}

// ── Back button ───────────────────────────────────────────────────────────────

class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.08),
                border: Border.all(color: Colors.white.withOpacity(0.15)),
              ),
              child: Icon(
                Icons.arrow_back_rounded,
                size: 18,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Back to Projects',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white.withOpacity(0.55),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Hero section ──────────────────────────────────────────────────────────────

class _HeroSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final String role;
  final String? liveUrl;
  final String? githubUrl;
  final bool isMobile;

  const _HeroSection({
    required this.title,
    required this.subtitle,
    required this.isMobile,
    this.role = '',
    this.liveUrl,
    this.githubUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 36 : 52,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          subtitle,
          style: GoogleFonts.inter(
            fontSize: isMobile ? 16 : 19,
            fontWeight: FontWeight.w300,
            color: Colors.white.withOpacity(0.55),
          ),
        ),
        if (role.isNotEmpty) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color(0xFFfeb800).withOpacity(0.12),
              border: Border.all(
                color: const Color(0xFFfeb800).withOpacity(0.4),
                width: 1,
              ),
            ),
            child: Text(
              role,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFfeb800),
              ),
            ),
          ),
        ],
        if (liveUrl != null || githubUrl != null) ...[
          const SizedBox(height: 28),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              if (liveUrl != null)
                _ActionButton(
                  label: 'Live Demo',
                  icon: Icons.open_in_new_rounded,
                  onTap: () => _launchURL(liveUrl!),
                ),
              if (githubUrl != null)
                _ActionButton(
                  label: 'GitHub',
                  icon: Icons.code_rounded,
                  onTap: () => _launchURL(githubUrl!),
                  outlined: true,
                ),
            ],
          ),
        ],
      ],
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}

// ── Tech stack card (grouped) ─────────────────────────────────────────────────

class _TechStackCard extends StatelessWidget {
  final Map<String, List<String>> techStack;
  const _TechStackCard({required this.techStack});

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: techStack.entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Group label
                Row(
                  children: [
                    Container(
                      width: 3,
                      height: 14,
                      decoration: BoxDecoration(
                        color: const Color(0xFFfeb800),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      entry.key,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFfeb800),
                        letterSpacing: 0.6,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: entry.value
                      .map((item) => _TagChip(label: item))
                      .toList(),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ── Tags card (flat list fallback) ────────────────────────────────────────────

class _TagsCard extends StatelessWidget {
  final List<String> tags;
  const _TagsCard({required this.tags});

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tech Stack',
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: const Color(0xFFfeb800),
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: tags.map((t) => _TagChip(label: t)).toList(),
          ),
        ],
      ),
    );
  }
}

// ── Two-column bullet list (for key features) ─────────────────────────────────

class _TwoColumnBulletList extends StatelessWidget {
  final List<String> items;
  final bool isMobile;
  const _TwoColumnBulletList({required this.items, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return _BulletList(items: items, isMobile: true);
    }
    // Split into two columns
    final int half = (items.length / 2).ceil();
    final left = items.sublist(0, half);
    final right = items.sublist(half);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _BulletList(items: left, isMobile: false)),
        const SizedBox(width: 24),
        Expanded(child: _BulletList(items: right, isMobile: false)),
      ],
    );
  }
}

// ── Bullet list ───────────────────────────────────────────────────────────────

class _BulletList extends StatelessWidget {
  final List<String> items;
  final bool isMobile;
  final bool accentBullet;
  const _BulletList({
    required this.items,
    required this.isMobile,
    this.accentBullet = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 7),
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: accentBullet
                        ? const Color(0xFFfeb800)
                        : Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item,
                  style: GoogleFonts.inter(
                    fontSize: isMobile ? 14 : 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withOpacity(0.8),
                    height: 1.7,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// ── Skill pill ────────────────────────────────────────────────────────────────

class _SkillPill extends StatelessWidget {
  final String label;
  const _SkillPill({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color(0xFFfeb800).withOpacity(0.1),
        border: Border.all(
          color: const Color(0xFFfeb800).withOpacity(0.35),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: const Color(0xFFfeb800).withOpacity(0.9),
        ),
      ),
    );
  }
}

// ── Glass card ────────────────────────────────────────────────────────────────

class _GlassCard extends StatelessWidget {
  final Widget child;
  const _GlassCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.07),
            border: Border.all(color: Colors.white.withOpacity(0.12), width: 1),
          ),
          child: child,
        ),
      ),
    );
  }
}

// ── Section label ─────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: const Color(0xFFfeb800),
        letterSpacing: 0.8,
      ),
    );
  }
}

// ── Tag chip ──────────────────────────────────────────────────────────────────

class _TagChip extends StatelessWidget {
  final String label;
  const _TagChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.25), width: 1),
        color: Colors.white.withOpacity(0.08),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.white.withOpacity(0.8),
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

// ── Action button ─────────────────────────────────────────────────────────────

// ── Action button (with loading state) ───────────────────────────────────────

class _ActionButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final Future<void> Function() onTap;
  final bool outlined;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.onTap,
    this.outlined = false,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  bool _loading = false;

  Future<void> _handleTap() async {
    if (_loading) return;
    setState(() => _loading = true);
    try {
      await widget.onTap();
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color fg = widget.outlined
        ? Colors.white.withOpacity(0.8)
        : Colors.black;
    return GestureDetector(
      onTap: _handleTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: widget.outlined
                ? Colors.transparent
                : const Color(0xFFfeb800),
            border: Border.all(
              color: widget.outlined
                  ? Colors.white.withOpacity(0.25)
                  : const Color(0xFFfeb800),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: _loading
                    ? SizedBox(
                        key: const ValueKey('spinner'),
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: fg,
                        ),
                      )
                    : Icon(
                        key: const ValueKey('icon'),
                        widget.icon,
                        size: 16,
                        color: fg,
                      ),
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: fg,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
