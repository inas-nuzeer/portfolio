// Web-only implementation — registers a <video> element inside a wrapper <div>
// and returns an HtmlElementView.
//
// The wrapper div has overflow:hidden + border-radius applied so the video
// is clipped at the DOM level. Flutter's ClipRRect has no effect on platform
// views, so this is the only reliable way to clip HtmlElementView on mobile.
//
// Asset URL resolution:
//   ui_web.assetManager.getAssetUrl(path) returns the correct absolute URL
//   for both debug (localhost) and production (GitHub Pages sub-path).

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

extension _ElementExt on JSObject {
  // video-specific
  external set src(String value);
  external set controls(bool value);
  external set autoplay(bool value);
  external void setAttribute(String name, String value);
  external void appendChild(JSObject child);
  external JSObject get style;
}

extension _StyleExt on JSObject {
  external set width(String value);
  external set height(String value);
  external set objectFit(String value);
  external set background(String value);
  external set overflow(String value);
  external set borderRadius(String value);
  external set display(String value);
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
    _viewId =
        'video-player-${widget.src.hashCode}-${DateTime.now().microsecondsSinceEpoch}';

    if (!_registeredVideoViews.contains(_viewId)) {
      _registeredVideoViews.add(_viewId);

      // Resolve to absolute URL so it works on GitHub Pages sub-paths.
      final String resolvedSrc = ui_web.assetManager.getAssetUrl(widget.src);

      ui_web.platformViewRegistry.registerViewFactory(_viewId, (_) {
        // ── Wrapper div — clips the video at the DOM level ──────────────
        final wrapper = _createElement('div');
        wrapper.style.width = '100%';
        wrapper.style.height = '100%';
        wrapper.style.overflow = 'hidden';
        wrapper.style.borderRadius = '16px';
        wrapper.style.background = '#000000';
        wrapper.style.display = 'flex';

        // ── Video element ───────────────────────────────────────────────
        final video = _createElement('video');
        video.src = resolvedSrc;
        video.controls = true;
        video.autoplay = false;
        video.setAttribute('playsinline', 'true');
        video.setAttribute('preload', 'metadata');

        video.style.width = '100%';
        video.style.height = '100%';
        video.style.objectFit = 'contain';
        video.style.background = '#000000';
        video.style.borderRadius = '16px';

        wrapper.appendChild(video);
        return wrapper;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(child: HtmlElementView(viewType: _viewId));
  }
}
