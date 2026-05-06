// ignore_for_file: avoid_web_libraries_in_flutter
// Web-only implementation — registers a <video> element and returns an HtmlElementView.

import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

import 'package:flutter/widgets.dart';

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
    // Unique ID per instance so multiple videos on the same page don't clash
    _viewId =
        'video-player-${widget.src.hashCode}-${DateTime.now().microsecondsSinceEpoch}';

    ui_web.platformViewRegistry.registerViewFactory(_viewId, (_) {
      final video = html.VideoElement()
        ..src = widget.src
        ..controls = true
        ..autoplay = false
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.objectFit = 'contain'
        ..style.background = '#000'
        ..setAttribute('playsinline', 'true');
      return video;
    });
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(viewType: _viewId);
  }
}
