// Web-only implementation — registers a <video> element and returns an HtmlElementView.
// Uses package:web + dart:js_interop (replaces deprecated dart:html).

// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:ui_web' as ui_web;

import 'package:flutter/widgets.dart';
import 'package:web/web.dart' as web;

// Track registered view IDs to avoid duplicate registration errors.
final Set<String> _registeredVideoViews = {};

Widget buildWebVideoPlayer(String src) {
  return _WebVideoPlayer(src: src);
}

class _WebVideoPlayer extends StatefulWidget {
  final String src;
  const _WebVideoPlayer({required this.src});

  @override
  State<_WebVideoPlayer> createState() => _WebVideoPlayerState();
}

class _WebVideoPlayerState extends State<_WebVideoPlayer> {
  late final String _viewId;

  @override
  void initState() {
    super.initState();
    // Unique ID per instance so multiple videos on the same page don't clash.
    _viewId =
        'video-player-${widget.src.hashCode}-${DateTime.now().microsecondsSinceEpoch}';

    if (!_registeredVideoViews.contains(_viewId)) {
      _registeredVideoViews.add(_viewId);
      ui_web.platformViewRegistry.registerViewFactory(_viewId, (_) {
        final video = web.HTMLVideoElement()
          ..src = widget.src
          ..controls = true
          ..autoplay = false
          ..setAttribute('playsinline', 'true')
          ..setAttribute('preload', 'metadata');

        video.style
          ..width = '100%'
          ..height = '100%'
          ..objectFit = 'contain'
          ..background = '#000000';

        return video;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(child: HtmlElementView(viewType: _viewId));
  }
}
