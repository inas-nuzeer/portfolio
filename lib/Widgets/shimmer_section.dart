// ignore_for_file: deprecated_member_use

import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// Displays a shimmer placeholder that mimics a full-screen section.
/// Used during pull-to-refresh loading state.
class ShimmerSection extends StatefulWidget {
  final double height;
  final bool hasGlass;

  const ShimmerSection({
    super.key,
    required this.height,
    this.hasGlass = false,
  });

  @override
  State<ShimmerSection> createState() => _ShimmerSectionState();
}

class _ShimmerSectionState extends State<ShimmerSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    Widget content = AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        // Sweep the highlight from left (-1) to right (2) across the card
        final double shimmerX = -1.0 + _controller.value * 3.0;

        return Container(
          width: screenWidth,
          height: widget.height,
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * .1,
            vertical: widget.height * .08,
          ),
          child: ShaderMask(
            blendMode: BlendMode.srcATop,
            shaderCallback: (bounds) => LinearGradient(
              begin: Alignment(shimmerX - 1, 0),
              end: Alignment(shimmerX + 1, 0),
              colors: const [
                Color(0x22FFFFFF),
                Color(0x55FFFFFF),
                Color(0xAAFFFFFF),
                Color(0x55FFFFFF),
                Color(0x22FFFFFF),
              ],
              stops: const [0.0, 0.3, 0.5, 0.7, 1.0],
            ).createShader(bounds),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section title placeholder
                _shimmerBox(width: screenWidth * .25, height: 40),
                const SizedBox(height: 32),
                // Content block placeholders
                _shimmerBox(width: double.infinity, height: 16),
                const SizedBox(height: 12),
                _shimmerBox(width: double.infinity, height: 16),
                const SizedBox(height: 12),
                _shimmerBox(width: screenWidth * .6, height: 16),
                const SizedBox(height: 32),
                // Card placeholders
                Row(
                  children: [
                    Expanded(child: _shimmerBox(height: 160)),
                    const SizedBox(width: 16),
                    Expanded(child: _shimmerBox(height: 160)),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    if (!widget.hasGlass) return content;

    // Wrap with the same glass backdrop used by real sections
    return ClipRRect(
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(color: Colors.white.withOpacity(0.05), child: content),
      ),
    );
  }

  Widget _shimmerBox({double? width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
