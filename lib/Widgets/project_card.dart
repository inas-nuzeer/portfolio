// ignore_for_file: deprecated_member_use

import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inas_portfolio/Screens/Projects/project_detail_page.dart';
import 'package:inas_portfolio/Widgets/project_detail_modal.dart';

class ProjectCard extends StatelessWidget {
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

  /// [true] → full detail page, [false] → modal (default)
  final bool openAsPage;

  const ProjectCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.role = '',
    this.description = '',
    this.tags = const [],
    this.liveUrl,
    this.githubUrl,
    this.mediaItems = const [],
    this.myRole = const [],
    this.keyContributions = const [],
    this.skillsDemonstrated = const [],
    this.techStack = const {},
    this.keyFeatures = const [],
    this.openAsPage = false,
  });

  void _handleTap(BuildContext context) {
    if (openAsPage) {
      ProjectDetailPage.push(
        context,
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
      );
    } else {
      ProjectDetailModal.show(
        context,
        title: title,
        subtitle: subtitle,
        description: description,
        tags: tags,
        liveUrl: liveUrl,
        githubUrl: githubUrl,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleTap(context),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white.withOpacity(0.07),
                border: Border.all(
                  color: Colors.white.withOpacity(0.12),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Subtitle
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Tags
                  if (tags.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: tags
                          .take(3)
                          .map((tag) => _Tag(label: tag))
                          .toList(),
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

class _Tag extends StatelessWidget {
  final String label;
  const _Tag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
        color: Colors.white.withOpacity(0.08),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Colors.white.withOpacity(0.75),
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
