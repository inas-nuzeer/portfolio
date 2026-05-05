// ignore_for_file: deprecated_member_use

import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inas_portfolio/Screens/MainContent/main_content.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // ── Controllers ────────────────────────────────────────────────────────────
  late final AnimationController _fadeInController;
  late final AnimationController _typewriterController;
  late final AnimationController _exitController;

  // ── Animations ─────────────────────────────────────────────────────────────
  late final Animation<double> _logoFade;
  late final Animation<double> _logoScale;
  late final Animation<double> _exitFade;

  // Typewriter state
  final String _fullName = 'Inas Nuzeer';
  final String _subtitle = 'Flutter Developer  ·  Software Engineer';
  String _displayedName = '';
  String _displayedSubtitle = '';
  bool _showCursor = true;
  bool _subtitleDone = false;

  @override
  void initState() {
    super.initState();

    // 1. Fade + scale in the logo/initials
    _fadeInController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _logoFade = CurvedAnimation(
      parent: _fadeInController,
      curve: Curves.easeOut,
    );
    _logoScale = Tween<double>(begin: 0.75, end: 1.0).animate(
      CurvedAnimation(parent: _fadeInController, curve: Curves.easeOutBack),
    );

    // 2. Typewriter drives the text reveal
    _typewriterController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: (_fullName.length + _subtitle.length) * 60 + 400,
      ),
    );

    // 3. Exit fade-out
    _exitController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _exitFade = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _exitController, curve: Curves.easeIn));

    // Cursor blink
    _startCursorBlink();

    // Kick off sequence
    _runSequence();
  }

  void _startCursorBlink() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 500));
      if (!mounted) return false;
      setState(() => _showCursor = !_showCursor);
      return !_subtitleDone;
    });
  }

  Future<void> _runSequence() async {
    // Step 1 — fade in logo
    await _fadeInController.forward();
    await Future.delayed(const Duration(milliseconds: 300));

    // Step 2 — type the name
    for (int i = 1; i <= _fullName.length; i++) {
      await Future.delayed(const Duration(milliseconds: 70));
      if (!mounted) return;
      setState(() => _displayedName = _fullName.substring(0, i));
    }

    await Future.delayed(const Duration(milliseconds: 200));

    // Step 3 — type the subtitle
    for (int i = 1; i <= _subtitle.length; i++) {
      await Future.delayed(const Duration(milliseconds: 35));
      if (!mounted) return;
      setState(() => _displayedSubtitle = _subtitle.substring(0, i));
    }

    setState(() => _subtitleDone = true);
    await Future.delayed(const Duration(milliseconds: 900));

    // Step 4 — fade out and navigate
    await _exitController.forward();
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const MainContent(),
        transitionDuration: const Duration(milliseconds: 600),
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  @override
  void dispose() {
    _fadeInController.dispose();
    _typewriterController.dispose();
    _exitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    return FadeTransition(
      opacity: _exitFade,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg_image_mobile.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: ScaleTransition(
              scale: _logoScale,
              child: FadeTransition(
                opacity: _logoFade,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ── Initials glass badge ──────────────────────────────
                    ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: BackdropFilter(
                        filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: Container(
                          width: isMobile ? 90 : 110,
                          height: isMobile ? 90 : 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            color: Colors.white.withOpacity(0.1),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                              width: 1.5,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'IN',
                              style: GoogleFonts.poppins(
                                fontSize: isMobile ? 36 : 44,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFFfeb800),
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: isMobile ? 28 : 36),

                    // ── Typewriter name ───────────────────────────────────
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _displayedName,
                          style: GoogleFonts.poppins(
                            fontSize: isMobile ? 28 : 40,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 1.5,
                          ),
                        ),
                        // Blinking cursor — only show while typing name
                        if (_displayedName.length < _fullName.length ||
                            _displayedSubtitle.isEmpty)
                          AnimatedOpacity(
                            opacity: _showCursor ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 100),
                            child: Text(
                              '|',
                              style: GoogleFonts.poppins(
                                fontSize: isMobile ? 28 : 40,
                                fontWeight: FontWeight.w300,
                                color: const Color(0xFFfeb800),
                              ),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // ── Typewriter subtitle ───────────────────────────────
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _displayedSubtitle,
                          style: GoogleFonts.inter(
                            fontSize: isMobile ? 12 : 15,
                            fontWeight: FontWeight.w300,
                            color: Colors.white.withOpacity(0.55),
                            letterSpacing: 1.2,
                          ),
                        ),
                        // Cursor moves to subtitle once name is done
                        if (_displayedName == _fullName && !_subtitleDone)
                          AnimatedOpacity(
                            opacity: _showCursor ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 100),
                            child: Text(
                              '|',
                              style: GoogleFonts.inter(
                                fontSize: isMobile ? 12 : 15,
                                fontWeight: FontWeight.w300,
                                color: const Color(0xFFfeb800),
                              ),
                            ),
                          ),
                      ],
                    ),

                    SizedBox(height: isMobile ? 48 : 64),

                    // ── Loading dots ──────────────────────────────────────
                    _LoadingDots(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Three animated bouncing dots shown at the bottom of the splash.
class _LoadingDots extends StatefulWidget {
  @override
  State<_LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<_LoadingDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (i) {
            // Each dot is offset by 0.2 in the animation cycle
            final double t = (_controller.value - i * 0.2).clamp(0.0, 1.0);
            final double bounce = (t < 0.5 ? t : 1.0 - t) * 2;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 6,
              height: 6,
              transform: Matrix4.translationValues(0, -8 * bounce, 0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFfeb800).withOpacity(0.4 + 0.6 * bounce),
              ),
            );
          }),
        );
      },
    );
  }
}
