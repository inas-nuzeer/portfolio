// ignore_for_file: deprecated_member_use

import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ── Media item model ──────────────────────────────────────────────────────────

enum MediaType { image, video }

class ProjectMediaItem {
  /// Asset path or network URL for the image / video thumbnail.
  final String src;
  final MediaType type;

  /// Optional caption shown below the slide.
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
  final String description;
  final List<String> tags;
  final String? liveUrl;
  final String? githubUrl;
  final List<ProjectMediaItem> mediaItems;

  const ProjectDetailPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    this.tags = const [],
    this.liveUrl,
    this.githubUrl,
    this.mediaItems = const [],
  });

  static void push(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String description,
    List<String> tags = const [],
    String? liveUrl,
    String? githubUrl,
    List<ProjectMediaItem> mediaItems = const [],
  }) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        reverseTransitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (_, animation, _) => ProjectDetailPage(
          title: title,
          subtitle: subtitle,
          description: description,
          tags: tags,
          liveUrl: liveUrl,
          githubUrl: githubUrl,
          mediaItems: mediaItems,
        ),
        transitionsBuilder: (_, animation, _, child) => FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
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
            image: isMobile
                ? const AssetImage('assets/images/bg_image_mobile.png')
                : const AssetImage('assets/images/bg_image.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? screenWidth * 0.06 : screenWidth * 0.12,
              vertical: 32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Back button ───────────────────────────────────────────
                const _BackButton(),

                SizedBox(height: screenHeight * 0.05),

                // ── Hero section ──────────────────────────────────────────
                isMobile
                    ? _HeroSection(
                        title: title,
                        subtitle: subtitle,
                        liveUrl: liveUrl,
                        githubUrl: githubUrl,
                        isMobile: true,
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: _HeroSection(
                              title: title,
                              subtitle: subtitle,
                              liveUrl: liveUrl,
                              githubUrl: githubUrl,
                              isMobile: false,
                            ),
                          ),
                          const SizedBox(width: 60),
                          Expanded(flex: 2, child: _TagsCard(tags: tags)),
                        ],
                      ),

                SizedBox(height: screenHeight * 0.06),

                // ── Media carousel ────────────────────────────────────────
                if (mediaItems.isNotEmpty) ...[
                  _SectionLabel(label: 'Screenshots & Videos'),
                  const SizedBox(height: 16),
                  _MediaCarousel(items: mediaItems, isMobile: isMobile),
                  SizedBox(height: screenHeight * 0.06),
                ],

                // ── About section ─────────────────────────────────────────
                _SectionLabel(label: 'About this project'),
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

                // ── Tags (mobile only) ────────────────────────────────────
                if (isMobile && tags.isNotEmpty) ...[
                  SizedBox(height: screenHeight * 0.04),
                  _SectionLabel(label: 'Tech Stack'),
                  const SizedBox(height: 16),
                  _TagsCard(tags: tags),
                ],

                SizedBox(height: screenHeight * 0.08),
              ],
            ),
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
    final double carouselHeight = widget.isMobile
        ? screenWidth *
              0.56 // ~16:9 on mobile
        : screenWidth * 0.38; // wider on desktop

    final bool hasCaption =
        widget.items[_currentIndex].caption?.isNotEmpty == true;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          // height: carouselHeight * .5,
          width: widget.isMobile ? double.infinity : screenWidth * .25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.06),
            border: Border.all(color: Colors.white.withOpacity(0.12), width: 1),
          ),
          child: Column(
            children: [
              // ── Slide area ──────────────────────────────────────────────
              SizedBox(
                height: widget.isMobile ? carouselHeight : carouselHeight * .4,
                width: widget.isMobile ? double.infinity : screenWidth * .25,
                child: Stack(
                  children: [
                    // PageView
                    PageView.builder(
                      controller: _pageController,
                      itemCount: widget.items.length,
                      onPageChanged: (i) => setState(() => _currentIndex = i),
                      itemBuilder: (_, i) => _MediaSlide(item: widget.items[i]),
                    ),

                    // Prev arrow
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

                    // Next arrow
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

                    // Media type badge (top-right)
                    Positioned(
                      top: 12,
                      right: 12,
                      child: _MediaBadge(
                        type: widget.items[_currentIndex].type,
                      ),
                    ),
                  ],
                ),
              ),

              // ── Caption + dots ──────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Column(
                  children: [
                    if (hasCaption) ...[
                      Text(
                        widget.items[_currentIndex].caption!,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: Colors.white.withOpacity(0.55),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 12),
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
}

// ── Single slide ──────────────────────────────────────────────────────────────

class _MediaSlide extends StatelessWidget {
  final ProjectMediaItem item;
  const _MediaSlide({required this.item});

  @override
  Widget build(BuildContext context) {
    return item.type == MediaType.image
        ? _ImageSlide(src: item.src)
        : _VideoSlide(src: item.src);
  }
}

class _ImageSlide extends StatelessWidget {
  final String src;
  const _ImageSlide({required this.src});

  bool get _isNetwork =>
      src.startsWith('http://') || src.startsWith('https://');

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: _isNetwork
          ? Image.network(
              src,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (_, _, _) => _ErrorPlaceholder(),
            )
          : Image.asset(
              src,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (_, _, _) => _ErrorPlaceholder(),
            ),
    );
  }
}

class _VideoSlide extends StatelessWidget {
  final String src;
  const _VideoSlide({required this.src});

  bool get _isNetwork =>
      src.startsWith('http://') || src.startsWith('https://');

  @override
  Widget build(BuildContext context) {
    // Thumbnail with play overlay — integrate video_player if needed
    return Stack(
      fit: StackFit.expand,
      children: [
        // Thumbnail (network) or dark placeholder (asset)
        _isNetwork
            ? Image.network(
                src,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => _DarkPlaceholder(),
              )
            : _DarkPlaceholder(),

        // Play button overlay
        Center(
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withOpacity(0.55),
              border: Border.all(
                color: Colors.white.withOpacity(0.4),
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.play_arrow_rounded,
              color: Colors.white,
              size: 36,
            ),
          ),
        ),
      ],
    );
  }
}

class _ErrorPlaceholder extends StatelessWidget {
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

class _DarkPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.04),
      child: Center(
        child: Icon(
          Icons.videocam_rounded,
          color: Colors.white.withOpacity(0.15),
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

// ── Media type badge ──────────────────────────────────────────────────────────

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
  final String? liveUrl;
  final String? githubUrl;
  final bool isMobile;

  const _HeroSection({
    required this.title,
    required this.subtitle,
    required this.isMobile,
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
        const SizedBox(height: 14),
        Text(
          subtitle,
          style: GoogleFonts.inter(
            fontSize: isMobile ? 16 : 19,
            fontWeight: FontWeight.w300,
            color: Colors.white.withOpacity(0.55),
          ),
        ),
        const SizedBox(height: 36),
        if (liveUrl != null || githubUrl != null)
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              if (liveUrl != null)
                _ActionButton(
                  label: 'Live Demo',
                  icon: Icons.open_in_new_rounded,
                  onTap: () {
                    /* TODO: launch(liveUrl!) */
                  },
                ),
              if (githubUrl != null)
                _ActionButton(
                  label: 'GitHub',
                  icon: Icons.code_rounded,
                  onTap: () {
                    /* TODO: launch(githubUrl!) */
                  },
                  outlined: true,
                ),
            ],
          ),
      ],
    );
  }
}

// ── Tags card ─────────────────────────────────────────────────────────────────

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

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool outlined;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.onTap,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: outlined ? Colors.transparent : const Color(0xFFfeb800),
            border: Border.all(
              color: outlined
                  ? Colors.white.withOpacity(0.25)
                  : const Color(0xFFfeb800),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 16,
                color: outlined ? Colors.white.withOpacity(0.8) : Colors.black,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: outlined
                      ? Colors.white.withOpacity(0.8)
                      : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
