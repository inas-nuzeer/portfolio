// Web-only implementation — registers a <video> element inside a wrapper <div>
// and returns an HtmlElementView.
//
// MOBILE SCROLL FIX:
// HtmlElementView platform views are rendered directly in the browser DOM and
// completely ignore Flutter's scroll/clip boundaries. When Flutter scrolls its
// canvas the <video> element stays at its original DOM position, causing the
// ghost-stacking bug visible on mobile browsers.
//
// Solution:
// 1. The wrapper div uses position:absolute + clip-path:inset(0) + contain:strict
//    so the browser itself clips the video to its box.
// 2. All videos start hidden (display:none). Only the active slide's video is
//    shown (display:block). This means off-screen videos have zero DOM presence.
// 3. pauseAndHideVideo / showVideo let the carousel toggle visibility.

// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:js_interop';
import 'dart:ui_web' as ui_web;

import 'package:flutter/widgets.dart';

// Track registered view IDs to avoid duplicate registration errors.
final Set<String> _registeredVideoViews = {};

// ── JS interop ────────────────────────────────────────────────────────────────

@JS('document.createElement')
external JSObject _createElement(String tag);

@JS('document.getElementById')
external JSObject? _getElementById(String id);

extension _ElementExt on JSObject {
  external set src(String value);
  external set controls(bool value);
  external set autoplay(bool value);
  external set id(String value);
  external void setAttribute(String name, String value);
  external void appendChild(JSObject child);
  external JSObject get style;
  external void pause();
}

extension _StyleExt on JSObject {
  external set width(String value);
  external set height(String value);
  external set objectFit(String value);
  external set background(String value);
  external set overflow(String value);
  external set borderRadius(String value);
  external set display(String value);
  external set contain(String value);
  external set clipPath(String value);
  external set maxWidth(String value);
  external set maxHeight(String value);
  external set boxSizing(String value);
}

// ── Public API ────────────────────────────────────────────────────────────────

Widget buildWebVideoPlayer(String src, {String? controlId}) {
  return _WebVideoPlayer(src: src, controlId: controlId);
}

/// Pause the video and hide the DOM element for the given [controlId].
/// Uses display:none so the element has zero visual presence — it cannot
/// bleed outside its container during scroll.
void pauseAndHideVideo(String controlId) {
  final video = _getElementById('video-$controlId');
  if (video != null) video.pause();

  final wrapper = _getElementById('wrapper-$controlId');
  if (wrapper != null) wrapper.style.display = 'none';
}

/// Make the video DOM element visible again (does NOT auto-play).
void showVideo(String controlId) {
  final wrapper = _getElementById('wrapper-$controlId');
  if (wrapper != null) wrapper.style.display = 'block';
}

// ── Widget ────────────────────────────────────────────────────────────────────

class _WebVideoPlayer extends StatefulWidget {
  final String src;
  final String? controlId;
  const _WebVideoPlayer({required this.src, this.controlId});

  @override
  State<_WebVideoPlayer> createState() => _WebVideoPlayerState();
}

class _WebVideoPlayerState extends State<_WebVideoPlayer> {
  late final String _viewId;
  late final String _wrapperId;
  late final String _videoId;
  late final bool _isFirstSlide;

  @override
  void initState() {
    super.initState();
    final String uid =
        '${widget.src.hashCode}-${DateTime.now().microsecondsSinceEpoch}';
    _viewId = 'video-player-$uid';
    _wrapperId = 'wrapper-${widget.controlId ?? uid}';
    _videoId = 'video-${widget.controlId ?? uid}';

    // The first slide (controlId ends in '-0') starts visible; all others
    // start hidden so they can't bleed during the initial render.
    _isFirstSlide =
        widget.controlId == null || widget.controlId!.endsWith('-0');

    if (!_registeredVideoViews.contains(_viewId)) {
      _registeredVideoViews.add(_viewId);

      final String resolvedSrc = ui_web.assetManager.getAssetUrl(widget.src);

      ui_web.platformViewRegistry.registerViewFactory(_viewId, (_) {
        // ── Wrapper div ─────────────────────────────────────────────────
        // overflow:hidden + contain:strict clips the video to this box even
        // on mobile browsers where Flutter's ClipRRect has no effect on
        // platform views.
        final wrapper = _createElement('div');
        wrapper.id = _wrapperId;
        wrapper.style.width = '100%';
        wrapper.style.height = '100%';
        wrapper.style.overflow = 'hidden';
        wrapper.style.borderRadius = '16px';
        wrapper.style.background = '#000000';
        wrapper.style.contain = 'strict';
        wrapper.style.clipPath = 'inset(0 round 16px)';
        wrapper.style.boxSizing = 'border-box';
        // Non-first slides start hidden to prevent scroll bleed.
        wrapper.style.display = _isFirstSlide ? 'block' : 'none';

        // ── Video element ───────────────────────────────────────────────
        final video = _createElement('video');
        video.id = _videoId;
        video.src = resolvedSrc;
        video.controls = true;
        video.autoplay = false;
        video.setAttribute('playsinline', 'true');
        video.setAttribute('preload', 'metadata');
        video.setAttribute('webkit-playsinline', 'true');

        video.style.width = '100%';
        video.style.height = '100%';
        video.style.objectFit = 'contain';
        video.style.background = '#000000';
        video.style.display = 'block';
        video.style.maxWidth = '100%';
        video.style.maxHeight = '100%';
        video.style.boxSizing = 'border-box';

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
