// ignore_for_file: deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inas_portfolio/Utils/Theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

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
          const SizedBox(height: 48),
          AutoSizeText(
            'References',
            style: GoogleFonts.poppins(
              fontSize: isMobileScreen ? 24 : 32,
              fontWeight: FontWeight.w600,
              color: AppTheme.lightTheme.primaryColor,
            ),
            maxLines: 1,
            minFontSize: 12,
          ),
          const SizedBox(height: 24),
          isMobileScreen
              ? const Column(
                  children: [
                    _ReferenceCard(
                      name: 'Muhammad Shahid',
                      role: 'Lecturer',
                      institution:
                          'National Textile University, Faisalabad, Pakistan',
                      emails: [
                        'shahid.abdullah@hotmail.com',
                        'shahid.abdullah@ntu.edu.pk',
                      ],
                      phone: '+92 300 8664042',
                      isMobile: true,
                    ),
                    SizedBox(height: 16),
                    _ReferenceCard(
                      name: 'Waqar Ahmad',
                      role: 'Assistant Professor',
                      details: 'Supervisor – Final Year Project (Xplorit)',
                      institution:
                          'National Textile University, Faisalabad, Pakistan',
                      emails: ['waqar@ntu.edu.pk', 'waqarzahoor@gmail.com'],
                      phone: '+92 300 6692006',
                      isMobile: true,
                    ),
                  ],
                )
              : const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _ReferenceCard(
                        name: 'Muhammad Shahid',
                        role: 'Lecturer',
                        institution:
                            'National Textile University, Faisalabad, Pakistan',
                        emails: [
                          'shahid.abdullah@hotmail.com',
                          'shahid.abdullah@ntu.edu.pk',
                        ],
                        phone: '+92 300 8664042',
                        isMobile: false,
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: _ReferenceCard(
                        name: 'Waqar Ahmad',
                        role: 'Assistant Professor',
                        details: 'Supervisor – Final Year Project (Xplorit)',
                        institution:
                            'National Textile University, Faisalabad, Pakistan',
                        emails: ['waqar@ntu.edu.pk', 'waqarzahoor@gmail.com'],
                        phone: '+92 300 6692006',
                        isMobile: false,
                      ),
                    ),
                  ],
                ),
          SizedBox(
            height: isMobileScreen ? screenHeight * .12 : screenHeight * .15,
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
            color: _hovering
                ? Colors.white.withOpacity(0.08)
                : Colors.white.withOpacity(0.04),
            border: Border.all(
              color: _hovering
                  ? accent.withOpacity(0.6)
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
                        color: Colors.white.withOpacity(0.45),
                      ),
                    ),
                  ],
                ),
              ),
              // ── View icon ─────────────────────────────────────────────
              Icon(
                Icons.open_in_full_rounded,
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

// ── Reference Card Widget ─────────────────────────────────────────────────────

class _ReferenceCard extends StatelessWidget {
  final String name;
  final String role;
  final String? details;
  final String institution;
  final List<String> emails;
  final String phone;
  final bool isMobile;

  const _ReferenceCard({
    required this.name,
    required this.role,
    this.details,
    required this.institution,
    required this.emails,
    required this.phone,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final Color accent = AppTheme.lightTheme.primaryColor;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: isMobile ? 16 : 24,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white.withOpacity(0.04),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: isMobile ? 38 : 46,
                height: isMobile ? 38 : 46,
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.person_rounded,
                  color: accent,
                  size: isMobile ? 20 : 24,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.poppins(
                        fontSize: isMobile ? 16 : 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    if (isMobile) ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            role,
                            style: GoogleFonts.inter(
                              fontSize: isMobile ? 13 : 15,
                              fontWeight: FontWeight.w500,
                              color: accent,
                            ),
                          ),
                          if (details != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              details!,
                              style: GoogleFonts.inter(
                                fontSize: isMobile ? 12 : 14,
                                fontStyle: FontStyle.italic,
                                color: Colors.white.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ] else ...[
                      Row(
                        children: [
                          Text(
                            role,
                            style: GoogleFonts.inter(
                              fontSize: isMobile ? 13 : 15,
                              fontWeight: FontWeight.w500,
                              color: accent,
                            ),
                          ),
                          if (details != null) ...[
                            const SizedBox(width: 12),
                            Text(
                              details!,
                              style: GoogleFonts.inter(
                                fontSize: isMobile ? 12 : 14,
                                fontStyle: FontStyle.italic,
                                color: Colors.white.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: Colors.white10, height: 1),
          const SizedBox(height: 16),
          // Institution
          _ContactRow(
            icon: Icons.location_city_rounded,
            text: institution,
            isMobile: isMobile,
          ),
          const SizedBox(height: 12),
          // Emails
          _ContactRow(
            icon: Icons.email_rounded,
            texts: emails,
            isMobile: isMobile,
            onTap: (email) => _launchURL('mailto:$email'),
          ),
          const SizedBox(height: 12),
          // Contact Number
          _ContactRow(
            icon: Icons.phone_rounded,
            text: phone,
            isMobile: isMobile,
            onTap: (phoneNumber) =>
                _launchURL('tel:${phoneNumber.replaceAll(' ', '')}'),
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

// ── Contact Row Widget ────────────────────────────────────────────────────────

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String? text;
  final List<String>? texts;
  final bool isMobile;
  final Function(String)? onTap;

  const _ContactRow({
    required this.icon,
    this.text,
    this.texts,
    required this.isMobile,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> items = texts ?? (text != null ? [text!] : []);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Icon(icon, color: Colors.white.withOpacity(0.5), size: 16),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: items.length == 1
              ? _HoverableText(
                  text: items.first,
                  isMobile: isMobile,
                  onTap: onTap != null ? () => onTap!(items.first) : null,
                )
              : Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: List.generate(items.length, (index) {
                    final item = items[index];
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _HoverableText(
                          text: item,
                          isMobile: isMobile,
                          onTap: onTap != null ? () => onTap!(item) : null,
                        ),
                        if (index < items.length - 1)
                          Text(
                            '  /  ',
                            style: GoogleFonts.inter(
                              fontSize: isMobile ? 12 : 14,
                              color: Colors.white.withOpacity(0.4),
                            ),
                          ),
                      ],
                    );
                  }),
                ),
        ),
      ],
    );
  }
}

// ── Hoverable Text Widget ─────────────────────────────────────────────────────

class _HoverableText extends StatefulWidget {
  final String text;
  final bool isMobile;
  final VoidCallback? onTap;

  const _HoverableText({
    required this.text,
    required this.isMobile,
    this.onTap,
  });

  @override
  State<_HoverableText> createState() => _HoverableTextState();
}

class _HoverableTextState extends State<_HoverableText> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final Color accent = AppTheme.lightTheme.primaryColor;
    final bool isLink = widget.onTap != null;

    return MouseRegion(
      cursor: isLink ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Text(
          widget.text,
          style: GoogleFonts.inter(
            fontSize: widget.isMobile ? 12 : 14,
            color: isLink
                ? (_isHovered ? accent : Colors.white.withOpacity(0.8))
                : Colors.white.withOpacity(0.8),
            decoration: isLink && _isHovered
                ? TextDecoration.underline
                : TextDecoration.none,
            decorationColor: accent,
          ),
        ),
      ),
    );
  }
}
