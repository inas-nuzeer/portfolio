// ignore_for_file: deprecated_member_use

import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'skills_data.dart';

class SkillCardWidget extends StatefulWidget {
  final SkillCard card;
  final int animationDelay; // ms

  const SkillCardWidget({
    super.key,
    required this.card,
    this.animationDelay = 0,
  });

  @override
  State<SkillCardWidget> createState() => _SkillCardWidgetState();
}

class _SkillCardWidgetState extends State<SkillCardWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnim;
  late final Animation<double> _slideAnim;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slideAnim = Tween<double>(
      begin: 30,
      end: 0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    Future.delayed(Duration(milliseconds: widget.animationDelay), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return FadeTransition(
          opacity: _fadeAnim,
          child: Transform.translate(
            offset: Offset(0, _slideAnim.value),
            child: MouseRegion(
              cursor: SystemMouseCursors.basic,
              onEnter: (_) => setState(() => _isHovered = true),
              onExit: (_) => setState(() => _isHovered = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                transform: Matrix4.identity()
                  ..translate(0.0, _isHovered ? -4.0 : 0.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: _isHovered
                            ? Colors.white.withOpacity(0.10)
                            : Colors.white.withOpacity(0.06),
                        border: Border.all(
                          color: _isHovered
                              ? widget.card.iconColor.withOpacity(0.5)
                              : Colors.white.withOpacity(0.10),
                          width: 1,
                        ),
                        boxShadow: _isHovered
                            ? [
                                BoxShadow(
                                  color: widget.card.iconColor.withOpacity(
                                    0.15,
                                  ),
                                  blurRadius: 24,
                                  spreadRadius: 2,
                                ),
                              ]
                            : [],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ── Icon + Title row ──────────────────────────
                          Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: widget.card.iconColor.withOpacity(
                                    _isHovered ? 0.20 : 0.12,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  widget.card.icon,
                                  color: widget.card.iconColor,
                                  size: 22,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  widget.card.title,
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 14),

                          // ── Bullet points ─────────────────────────────
                          ...widget.card.bullets.map(
                            (b) => Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 6,
                                      right: 8,
                                    ),
                                    child: Container(
                                      width: 4,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        color: widget.card.iconColor
                                            .withOpacity(0.8),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      b,
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: Colors.white.withOpacity(0.65),
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 14),

                          // ── Pill tags ─────────────────────────────────
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: widget.card.tags.map((tag) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: widget.card.iconColor.withOpacity(
                                    _isHovered ? 0.18 : 0.10,
                                  ),
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    color: widget.card.iconColor.withOpacity(
                                      _isHovered ? 0.50 : 0.25,
                                    ),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  tag,
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: widget.card.iconColor,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
