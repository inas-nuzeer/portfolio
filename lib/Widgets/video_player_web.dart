// Web-only implementation — registers a <video> element and returns an HtmlElementView.
// Uses dart:js_interop (Dart 3+) to create the DOM element without needing
// package:web or the deprecated dart:html.

// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:js_interop';
import 'dart:ui_web' as ui_web;

import 'package:flutter/widgets.dart';

// Track registered view IDs to avoid duplicate registration errors.
final Set<String> _registeredVideoViews = {};

Widget buildWebVideoPlayer(String src) {
  return _WebVideoPlayer(src: src);
}

// ── JS interop bindings ───────────────────────────────────────────────────────

@JS('document.createElement')
external JSObject _createElement(String tag);

extension _VideoElementExt on JSObject {
  external set src(String value);
  external set controls(bool value);
  external set autoplay(bool value);
  external void setAttribute(String name, String value);
  external JSObject get style;
}

extension _StyleExt on JSObject {
  external set width(String value);
  external set height(String value);
  external set objectFit(String value);
  external set background(String value);
}

// ── Widget ────────────────────────────────────────────────────────────────────

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

      final capturedSrc = widget.src;
      ui_web.platformViewRegistry.registerViewFactory(_viewId, (_) {
        final video = _createElement('video');
        video.src = capturedSrc;
        video.controls = true;
        video.autoplay = false;
        video.setAttribute('playsinline', 'true');
        video.setAttribute('preload', 'metadata');

        video.style.width = '100%';
        video.style.height = '100%';
        video.style.objectFit = 'contain';
        video.style.background = '#000000';

        return video;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(child: HtmlElementView(viewType: _viewId));
  }
}
