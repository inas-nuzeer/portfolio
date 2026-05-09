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
            minFontSize: 12,
            stepGranularity: 1,
            overflow: TextOverflow.clip,
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
          const SizedBox(height: 40),
          // ── Image cards ────────────────────────────────────────────────
          isMobileScreen
              ? const Column(
                  children: [
                    _ImageCard(
                      icon: Icons.school_rounded,
                      label: 'Degree Certificate',
                      assetPath: 'assets/files/Inas-Nuzeer-Degree.jpg',
                      isMobile: true,
                    ),
                    SizedBox(height: 16),
                    _ImageCard(
                      icon: Icons.description_rounded,
                      label: 'Academic Transcript',
                      assetPath: 'assets/files/Inas-Nuzeer-Transcript.jpg',
                      isMobile: true,
                    ),
                    SizedBox(height: 16),
                    _ImageCard(
                      icon: Icons.emoji_events_rounded,
                      label: 'FYP Certificate',
                      assetPath: 'assets/files/FYP-Certificate.jpg',
                      isMobile: true,
                    ),
                  ],
                )
              : const Row(
                  children: [
                    Expanded(
                      child: _ImageCard(
                        icon: Icons.school_rounded,
                        label: 'Degree Certificate',
                        assetPath: 'assets/files/Inas-Nuzeer-Degree.jpg',
                        isMobile: false,
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: _ImageCard(
                        icon: Icons.description_rounded,
                        label: 'Academic Transcript',
                        assetPath: 'assets/files/Inas-Nuzeer-Transcript.jpg',
                        isMobile: false,
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: _ImageCard(
                        icon: Icons.emoji_events_rounded,
                        label: 'FYP Certificate',
                        assetPath: 'assets/files/FYP-Certificate.jpg',
                        isMobile: false,
                      ),
                    ),
                  ],
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
                          : title),
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
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Image card with lightbox ──────────────────────────────────────────────────

class _ImageCard extends StatefulWidget {
  final IconData icon;
  final String label;
  final String assetPath;
  final bool isMobile;

  const _ImageCard({
    required this.icon,
    required this.label,
    required this.assetPath,
    required this.isMobile,
  });

  @override
  State<_ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<_ImageCard> {
  bool _hovering = false;

  void _openLightbox(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(24),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            // ── Image ────────────────────────────────────────────────────
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: InteractiveViewer(
                child: Image.asset(widget.assetPath, fit: BoxFit.contain),
              ),
            ),
            // ── Close button ─────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(8),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: const Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = widget.isMobile;
    final Color accent = AppTheme.lightTheme.primaryColor; // #feb800

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _openLightbox(context),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 24,
            vertical: isMobile ? 16 : 20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            // ignore: deprecated_member_use
            color: _hovering
                // ignore: deprecated_member_use
                ? Colors.white.withOpacity(0.08)
                // ignore: deprecated_member_use
                : Colors.white.withOpacity(0.04),
            border: Border.all(
              // ignore: deprecated_member_use
              color: _hovering
                  // ignore: deprecated_member_use
                  ? accent.withOpacity(0.6)
                  // ignore: deprecated_member_use
                  : Colors.white.withOpacity(0.1),
              width: 1.2,
            ),
          ),
          child: Row(
            children: [
              // ── Icon box ───────────────────────────────────────────────
              Container(
                width: isMobile ? 42 : 52,
                height: isMobile ? 42 : 52,
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: accent.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  widget.icon,
                  color: accent,
                  size: isMobile ? 22 : 26,
                ),
              ),
              const SizedBox(width: 16),
              // ── Label + hint ───────────────────────────────────────────
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.label,
                      style: GoogleFonts.poppins(
                        fontSize: isMobile ? 14 : 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Tap to view',
                      style: GoogleFonts.inter(
                        fontSize: isMobile ? 11 : 13,
                        // ignore: deprecated_member_use
                        color: Colors.white.withOpacity(0.45),
                      ),
                    ),
                  ],
                ),
              ),
              // ── View icon ─────────────────────────────────────────────
              Icon(
                Icons.open_in_full_rounded,
                // ignore: deprecated_member_use
                color: _hovering ? accent : Colors.white.withOpacity(0.4),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
