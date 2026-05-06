// ignore_for_file: deprecated_member_use

import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectDetailModal extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final List<String> tags;
  final String? liveUrl;
  final String? githubUrl;

  const ProjectDetailModal({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    this.tags = const [],
    this.liveUrl,
    this.githubUrl,
  });

  static void show(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String description,
    List<String> tags = const [],
    String? liveUrl,
    String? githubUrl,
  }) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (_) => ProjectDetailModal(
        title: title,
        subtitle: subtitle,
        description: description,
        tags: tags,
        liveUrl: liveUrl,
        githubUrl: githubUrl,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;
    final double modalWidth = isMobile ? screenWidth * 0.92 : 600;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isMobile
            ? screenWidth * 0.04
            : (screenWidth - modalWidth) / 2,
        vertical: 40,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: Container(
            width: modalWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.white.withOpacity(0.08),
              border: Border.all(
                color: Colors.white.withOpacity(0.15),
                width: 1,
              ),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ── Header row ──────────────────────────────────────────
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: GoogleFonts.poppins(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.1),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                            ),
                          ),
                          child: Icon(
                            Icons.close_rounded,
                            size: 16,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // ── Subtitle ─────────────────────────────────────────────
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ── Divider ──────────────────────────────────────────────
                  Divider(color: Colors.white.withOpacity(0.1), height: 1),

                  const SizedBox(height: 24),

                  // ── Description label ────────────────────────────────────
                  Text(
                    'About this project',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFfeb800),
                      letterSpacing: 0.8,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // ── Description body ─────────────────────────────────────
                  Text(
                    description,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withOpacity(0.75),
                      height: 1.7,
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ── Tags ─────────────────────────────────────────────────
                  if (tags.isNotEmpty) ...[
                    Text(
                      'Tech Stack',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFfeb800),
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: tags
                          .map((tag) => _ModalTag(label: tag))
                          .toList(),
                    ),
                    const SizedBox(height: 28),
                  ],

                  // ── Action buttons ───────────────────────────────────────
                  if (liveUrl != null || githubUrl != null)
                    Row(
                      children: [
                        if (liveUrl != null)
                          _ActionButton(
                            label: 'Live Demo',
                            icon: Icons.open_in_new_rounded,
                            onTap: () {
                              // TODO: launch(liveUrl!)
                            },
                          ),
                        if (liveUrl != null && githubUrl != null)
                          const SizedBox(width: 12),
                        if (githubUrl != null)
                          _ActionButton(
                            label: 'GitHub',
                            icon: Icons.code_rounded,
                            onTap: () {
                              // TODO: launch(githubUrl!)
                            },
                            outlined: true,
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Tag chip ────────────────────────────────────────────────────────────────

class _ModalTag extends StatelessWidget {
  final String label;
  const _ModalTag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.25), width: 1),
        color: Colors.white.withOpacity(0.08),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.white.withOpacity(0.8),
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

// ── Action button ────────────────────────────────────────────────────────────

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
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
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
              size: 15,
              color: outlined ? Colors.white.withOpacity(0.8) : Colors.black,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: outlined ? Colors.white.withOpacity(0.8) : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
