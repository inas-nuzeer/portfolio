// Web-only video player implementation.
//
// Problem: HtmlElementView (platform view) does NOT scroll with Flutter's
// scroll view — it stays fixed in the DOM, causing the "ghost" overlay bug.
//
// Solution: Show a styled play-button thumbnail inside the scroll view.
// When tapped, open a full-screen Flutter overlay (outside the scroll context)
// that contains the actual HtmlElementView. This keeps the platform view
// out of the scrollable area entirely.

// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final Set<String> _registeredVideoViews = {};

Widget buildWebVideoPlayer(String src) => _VideoThumbnail(src: src);

// ── Thumbnail with play button (lives inside the scroll view) ─────────────────

class _VideoThumbnail extends StatelessWidget {
  final String src;
  const _VideoThumbnail({required this.src});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _VideoOverlay.show(context, src),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          color: Colors.black,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Play button circle
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFfeb800),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFfeb800).withOpacity(0.4),
                        blurRadius: 24,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.black,
                    size: 36,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'Tap to play',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Full-screen overlay (outside scroll context) ──────────────────────────────

class _VideoOverlay extends StatefulWidget {
  final String src;
  const _VideoOverlay({required this.src});

  static void show(BuildContext context, String src) {
    Navigator.of(context, rootNavigator: true).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black.withOpacity(0.92),
        pageBuilder: (_, __, ___) => _VideoOverlay(src: src),
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
        transitionDuration: const Duration(milliseconds: 200),
      ),
    );
  }

  @override
  State<_VideoOverlay> createState() => _VideoOverlayState();
}

class _VideoOverlayState extends State<_VideoOverlay> {
  late final String _viewId;

  @override
  void initState() {
    super.initState();
    _viewId =
        'video-overlay-${widget.src.hashCode}-${DateTime.now().microsecondsSinceEpoch}';

    if (!_registeredVideoViews.contains(_viewId)) {
      _registeredVideoViews.add(_viewId);
      // ignore: undefined_prefixed_name
      ui_web.platformViewRegistry.registerViewFactory(_viewId, (_) {
        final video = html.VideoElement()
          ..src = widget.src
          ..controls = true
          ..autoplay = true
          ..style.width = '100%'
          ..style.height = '100%'
          ..style.objectFit = 'contain'
          ..style.background = '#000'
          ..setAttribute('playsinline', 'true')
          ..setAttribute('preload', 'auto');
        return video;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Close on tap outside
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(color: Colors.transparent),
          ),

          // Video player centered
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: HtmlElementView(viewType: _viewId),
                ),
              ),
            ),
          ),

          // Close button
          Positioned(
            top: 48,
            right: 24,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.15),
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: const Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
