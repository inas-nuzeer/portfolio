// ignore_for_file: deprecated_member_use, avoid_web_libraries_in_flutter

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

// Conditionally import dart:html only on web
import 'video_player_web.dart' if (dart.library.io) 'video_player_stub.dart';

/// Drop-in video player.
/// - Web  → native <video> element via HtmlElementView (no extra package)
/// - Other → "Watch Video" button that opens the URL in the browser
class VideoPlayerWidget extends StatelessWidget {
  final String src;

  const VideoPlayerWidget({super.key, required this.src});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return buildWebVideoPlayer(src);
    }
    return _FallbackPlayer(src: src);
  }
}

// ── Non-web fallback ──────────────────────────────────────────────────────────

class _FallbackPlayer extends StatelessWidget {
  final String src;
  const _FallbackPlayer({required this.src});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.videocam_rounded,
              color: Colors.white.withOpacity(0.3),
              size: 48,
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () async {
                final uri = Uri.parse(src);
                if (await canLaunchUrl(uri)) launchUrl(uri);
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xFFfeb800),
                  ),
                  child: Text(
                    'Watch Video',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
