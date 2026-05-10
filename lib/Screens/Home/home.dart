// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isHoveringOnLink = false;
  bool _isHoveringOnGithub = false;
  bool _isLaunchingLink = false;

  Future<void> _launchURL(String url) async {
    if (_isLaunchingLink) return;
    setState(() => _isLaunchingLink = true);
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) await launchUrl(uri);
    } finally {
      if (mounted) setState(() => _isLaunchingLink = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isMobile = screenWidth < 600;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * .1),
      child: SizedBox(
        height: screenHeight,
        child: Stack(
          children: [
            // ── Main content column ──────────────────────────────────────
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: screenHeight),
              child: Column(
                mainAxisAlignment: isMobile
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Role label ─────────────────────────────────────────
                  FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Software Developer · Flutter | Laravel',
                          style: const TextStyle(
                            color: Color(0xFFfeb800),
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 600.ms, curve: Curves.easeOut)
                      .slideY(
                        begin: 0.3,
                        end: 0,
                        duration: 600.ms,
                        curve: Curves.easeOut,
                      ),

                  // ── Name ───────────────────────────────────────────────
                  FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Inas Nuzeer',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      )
                      .animate()
                      .fadeIn(
                        delay: 150.ms,
                        duration: 700.ms,
                        curve: Curves.easeOut,
                      )
                      .slideY(
                        begin: 0.25,
                        end: 0,
                        delay: 150.ms,
                        duration: 700.ms,
                        curve: Curves.easeOut,
                      )
                      .shimmer(
                        delay: 900.ms,
                        duration: 1200.ms,
                        color: Colors.white.withOpacity(0.25),
                      ),

                  SizedBox(height: screenHeight * .04),

                  // ── Contact info ───────────────────────────────────────
                  if (isMobile) ...[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _personalData1(isMobile),
                        const SizedBox(height: 10),
                        _personalData2(isMobile),
                      ],
                    ),
                  ] else ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(flex: 1, child: _personalData1(false)),
                        const SizedBox(width: 30),
                        Expanded(flex: 3, child: _personalData2(false)),
                      ],
                    ),
                  ],
                  SizedBox(height: isMobile ? 10 : 30),
                  _animatedCard(
                    delay: 520.ms,
                    child: MouseRegion(
                      onEnter: (_) =>
                          setState(() => _isHoveringOnGithub = true),
                      onExit: (_) =>
                          setState(() => _isHoveringOnGithub = false),
                      child: InkWell(
                        onTap: () =>
                            _launchURL('https://www.github.com/inas-nuzeer'),
                        child: Row(
                          children: [
                            if (_isLaunchingLink)
                              const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Color(0xFFfeb800),
                                ),
                              )
                            else
                              Image.asset(
                                'assets/icons/github-24.png',
                                width: 20,
                                height: 20,
                              ),
                            const SizedBox(width: 8),
                            Text(
                              'github.com/inas-nuzeer',
                              style: TextStyle(
                                color: _isHoveringOnGithub
                                    ? const Color(0xFFfeb800)
                                    : Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (isMobile) ...[SizedBox(height: screenHeight * .12)],
                ],
              ),
            ),

            // ── "Open to Work" badge ─────────────────────────────────────
            Positioned(
              top: screenHeight * .03,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                              Icons.brightness_1,
                              size: 13,
                              color: Colors.green,
                            )
                            .animate(onPlay: (c) => c.repeat(reverse: true))
                            .fadeIn(duration: 400.ms)
                            .then()
                            .custom(
                              duration: 1200.ms,
                              builder: (_, value, child) => Opacity(
                                opacity: 0.4 + 0.6 * value,
                                child: child,
                              ),
                            ),
                        const SizedBox(width: 5),
                        const Text(
                              'Open to Work',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            )
                            .animate()
                            .fadeIn(delay: 200.ms, duration: 500.ms)
                            .slideX(
                              begin: -0.2,
                              end: 0,
                              delay: 200.ms,
                              duration: 500.ms,
                              curve: Curves.easeOut,
                            ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Contact columns ────────────────────────────────────────────────────────

  Widget _personalData1(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _animatedCard(
          delay: 400.ms,
          child: _personalDataCard(
            Icons.email_outlined,
            'inasnuzeer@gmail.com',
          ),
        ),
        SizedBox(height: isMobile ? 10 : 30),
        _animatedCard(
          delay: 520.ms,
          child: MouseRegion(
            onEnter: (_) => setState(() => _isHoveringOnLink = true),
            onExit: (_) => setState(() => _isHoveringOnLink = false),
            child: InkWell(
              onTap: () => _launchURL(
                'https://www.linkedin.com/in/inas-nuzeer-22b709202/',
              ),
              child: Row(
                children: [
                  if (_isLaunchingLink)
                    const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Color(0xFFfeb800),
                      ),
                    )
                  else
                    Image.asset(
                      'assets/icons/linkedin_16.png',
                      width: 20,
                      height: 20,
                    ),
                  const SizedBox(width: 8),
                  Text(
                    'linkedin.com/inas-nuzeer',
                    style: TextStyle(
                      color: _isHoveringOnLink
                          ? const Color(0xFFfeb800)
                          : Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _personalData2(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _animatedCard(
          delay: 640.ms,
          child: _personalDataCard(
            Icons.phone_android_outlined,
            '+94 76 418 9477',
          ),
        ),
        SizedBox(height: isMobile ? 10 : 30),
        _animatedCard(
          delay: 760.ms,
          child: _personalDataCard(Icons.map_outlined, 'Mawanella, Sri Lanka'),
        ),
      ],
    );
  }

  /// Wraps a child in a staggered fade + slide-up entrance.
  Widget _animatedCard({required Duration delay, required Widget child}) {
    return child
        .animate()
        .fadeIn(delay: delay, duration: 500.ms, curve: Curves.easeOut)
        .slideY(
          begin: 0.2,
          end: 0,
          delay: delay,
          duration: 500.ms,
          curve: Curves.easeOut,
        );
  }

  Widget _personalDataCard(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: const Color(0xFFfeb800)),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 20,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
