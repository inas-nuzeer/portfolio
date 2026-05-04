// ignore_for_file: deprecated_member_use

import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final double borderRadius;
  final double blurStrength;
  final Color color;
  final double opacity;
  final double paddingValue;
  final bool isMobileScreen;
  final bool isTabScreen;

  const GlassContainer({
    super.key,
    this.child = const SizedBox(),
    this.width = 0,
    this.height = 0,
    this.borderRadius = 0,
    this.blurStrength = 20,
    this.color = Colors.white,
    this.opacity = 0.1,
    this.paddingValue = 0,
    this.isMobileScreen = false,
    this.isTabScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: isMobileScreen ? 15 : paddingValue,
        ),
        width: isMobileScreen ? double.infinity : width,
        height: height != 0 ? height : null,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: color.withOpacity(opacity),
          border: Border.all(color: Colors.white.withOpacity(0.03), width: 1),
        ),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(
            sigmaX: blurStrength,
            sigmaY: blurStrength,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: Colors.transparent,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
