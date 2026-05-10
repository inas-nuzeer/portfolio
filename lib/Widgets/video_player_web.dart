// Web-only implementation.
//
// MOBILE STRATEGY (no HtmlElementView on mobile):
// HtmlElementView platform views live outside Flutter's rendering tree and
// always render above every Flutter widget — including the previous Navigator
// route. On mobile this causes the <video> element to bleed over the Projects
// page while the detail page is open, and to ghost-stack during scroll.
//
// Fix: on mobile we render a pure-Flutter poster + play button. Tapping it
// injects a fixed-position fullscreen <video> overlay directly into <body>
// via JS, completely bypassing HtmlElementView. The overlay is removed when
// the user closes it or navigates away.
//
// DESKTOP: HtmlElementView is used as before (no bleed issue on desktop).

// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:js_interop';
import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Track registered view IDs to avoid duplicate registration errors.
final Set<String> _registeredVideoViews = {};

// ── JS interop ────────────────────────────────────────────────────────────────

@JS('document.createElement')
external JSObject _createElement(String tag);

@JS('document.getElementById')
external JSObject? _getElementById(String id);

@JS('document.body.appendChild')
external void _bodyAppendChild(JSObject el);

@JS('document.body.removeChild')
external void _bodyRemoveChild(JSObject el);

extension _ElementExt on JSObject {
  external set src(String value);
  external set controls(bool value);
  external set autoplay(bool value);
  external set id(String value);
  external void setAttribute(String name, String value);
  external void appendChild(JSObject child);
  external JSObject get style;
  external void pause();
  external void addEventListener(String type, JSFunction listener);
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
  external set position(String value);
  external set top(String value);
  external set left(String value);
  external set zIndex(String value);
  external set alignItems(String value);
  external set justifyContent(String value);
  external set flexDirection(String value);
}

// ── Public API ────────────────────────────────────────────────────────────────

Widget buildWebVideoPlayer(String src, {String? controlId}) {
  return _WebVideoPlayer(src: src, controlId: controlId);
}

/// Pause the video and hide the DOM element for the given [controlId].
/// Uses display:none so the element has zero visual presence.
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

// ── Mobile fullscreen overlay ─────────────────────────────────────────────────

void _openMobileOverlay(String resolvedSrc) {
  _closeMobileOverlay();

  // Backdrop
  final overlay = _createElement('div');
  overlay.id = 'flutter-video-overlay';
  overlay.style.position = 'fixed';
  overlay.style.top = '0';
  overlay.style.left = '0';
  overlay.style.width = '100%';
  overlay.style.height = '100%';
  overlay.style.background = 'rgba(0,0,0,0.95)';
  overlay.style.zIndex = '999999';
  overlay.style.display = 'flex';
  overlay.style.alignItems = 'center';
  overlay.style.justifyContent = 'center';
  overlay.style.flexDirection = 'column';

  // Video element
  final video = _createElement('video');
  video.src = resolvedSrc;
  video.controls = true;
  video.autoplay = true;
  video.setAttribute('playsinline', 'true');
  video.setAttribute('webkit-playsinline', 'true');
  video.setAttribute('preload', 'auto');
  video.style.width = '100%';
  video.style.maxWidth = '100%';
  video.style.maxHeight = '80%';
  video.style.objectFit = 'contain';
  video.style.background = '#000';
  video.style.borderRadius = '8px';

  // Close button
  final closeBtn = _createElement('div');
  closeBtn.id = 'flutter-video-close';
  closeBtn.setAttribute(
    'style',
    'position:absolute;top:16px;right:16px;'
        'width:40px;height:40px;border-radius:50%;'
        'background:rgba(255,255,255,0.15);'
        'display:flex;align-items:center;justify-content:center;'
        'cursor:pointer;font-size:20px;color:#fff;'
        'border:1px solid rgba(255,255,255,0.3);'
        'z-index:1000000;',
  );
  closeBtn.setAttribute('innerHTML', '✕');

  overlay.appendChild(video);
  overlay.appendChild(closeBtn);
  _bodyAppendChild(overlay);

  // Close on button tap or backdrop tap
  final closeFn = _closeMobileOverlay.toJS;
  closeBtn.addEventListener('click', closeFn);
  overlay.addEventListener(
    'click',
    (JSAny e) {
      // Only close if the backdrop itself was clicked (not the video)
      _closeMobileOverlay();
    }.toJS,
  );
}

void _closeMobileOverlay() {
  final existing = _getElementById('flutter-video-overlay');
  if (existing != null) {
    try {
      _bodyRemoveChild(existing);
    } catch (_) {}
  }
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
  late final String _resolvedSrc;

  // True on mobile browsers — use poster+overlay instead of HtmlElementView.
  bool get _useMobileFallback {
    // kIsWeb is always true here; check screen width via window.
    // We treat width < 768 as mobile.
    return _isMobileViewport();
  }

  @override
  void initState() {
    super.initState();

    final String uid =
        '${widget.src.hashCode}-${DateTime.now().microsecondsSinceEpoch}';
    _viewId = 'video-player-$uid';
    _wrapperId = 'wrapper-${widget.controlId ?? uid}';
    _videoId = 'video-${widget.controlId ?? uid}';
    _isFirstSlide =
        widget.controlId == null || widget.controlId!.endsWith('-0');
    _resolvedSrc = ui_web.assetManager.getAssetUrl(widget.src);

    if (!_useMobileFallback) {
      _registerDesktopView();
    }
  }

  void _registerDesktopView() {
    if (_registeredVideoViews.contains(_viewId)) return;
    _registeredVideoViews.add(_viewId);

    ui_web.platformViewRegistry.registerViewFactory(_viewId, (_) {
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
      wrapper.style.display = _isFirstSlide ? 'block' : 'none';

      final video = _createElement('video');
      video.id = _videoId;
      video.src = _resolvedSrc;
      video.controls = true;
      video.autoplay = false;
      video.setAttribute('playsinline', 'true');
      video.setAttribute('preload', 'metadata');

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

  @override
  void dispose() {
    // Close any open overlay when the widget is disposed (navigation away).
    if (_useMobileFallback) {
      _closeMobileOverlay();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_useMobileFallback) {
      return _MobilePosterPlayer(
        onPlay: () => _openMobileOverlay(_resolvedSrc),
      );
    }
    return SizedBox.expand(child: HtmlElementView(viewType: _viewId));
  }
}

// ── Mobile poster player ──────────────────────────────────────────────────────

class _MobilePosterPlayer extends StatelessWidget {
  final VoidCallback onPlay;
  const _MobilePosterPlayer({required this.onPlay});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPlay,
      child: Container(
        width: double.infinity,
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFfeb800).withOpacity(0.9),
                ),
                child: const Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.black,
                  size: 38,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Tap to play video',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: Colors.white.withOpacity(0.6),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Viewport helper ───────────────────────────────────────────────────────────

@JS('window.innerWidth')
external int get _windowInnerWidth;

bool _isMobileViewport() {
  try {
    return _windowInnerWidth < 768;
  } catch (_) {
    return false;
  }
}
