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

  const GlassContainer({
    super.key,
    this.child = const SizedBox(),
    this.width = 0,
    this.height = 50,
    this.borderRadius = 10,
    this.blurStrength = 20,
    this.color = Colors.white,
    this.opacity = 0.1,
    this.paddingValue = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        padding: EdgeInsets.all(paddingValue),
        // width: width,
        // height: height,
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
