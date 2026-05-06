// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inas_portfolio/Screens/Skills/skill_card_widget.dart';
import 'package:inas_portfolio/Screens/Skills/skills_data.dart';

class Skill extends StatefulWidget {
  const Skill({super.key});

  @override
  State<Skill> createState() => _SkillState();
}

class _SkillState extends State<Skill> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int _activeTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: skillTabs.length, vsync: this)
      ..addListener(() {
        if (_tabController.indexIsChanging) return;
        setState(() => _activeTab = _tabController.index);
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isMobile = screenWidth < 600;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Available height — at least one full screen, possibly more if
        // the parent ConstrainedBox gives more room.
        final double availableHeight = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : screenHeight;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * .1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * .03),

              // ── Section title (fixed) ────────────────────────────────
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'Skills',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),

              SizedBox(height: screenHeight * .01),

              // ── Tab bar (fixed) ──────────────────────────────────────
              _SkillTabBar(
                controller: _tabController,
                activeIndex: _activeTab,
                isMobile: isMobile,
              ),

              SizedBox(height: screenHeight * .02),

              // ── Scrollable tab content ───────────────────────────────
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.04, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                ),
                child: _TabContent(
                  key: ValueKey(_activeTab),
                  tab: skillTabs[_activeTab],
                  isMobile: isMobile,
                  screenWidth: screenWidth,
                ),
              ),
              SizedBox(
                height: isMobile ? screenHeight * .12 : screenHeight * .04,
              ),
            ],
          ),
        );
      },
    );
  }
}

// ── Tab bar ────────────────────────────────────────────────────────────────────

class _SkillTabBar extends StatelessWidget {
  final TabController controller;
  final int activeIndex;
  final bool isMobile;

  const _SkillTabBar({
    required this.controller,
    required this.activeIndex,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      isScrollable: isMobile,
      tabAlignment: isMobile ? TabAlignment.start : TabAlignment.fill,
      dividerColor: Colors.white.withOpacity(0.08),
      indicatorColor: const Color(0xFFfeb800),
      indicatorWeight: 2.5,
      indicatorSize: TabBarIndicatorSize.label,
      labelPadding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 8,
        vertical: 0,
      ),
      tabs: List.generate(skillTabs.length, (i) {
        final tab = skillTabs[i];
        final bool isActive = activeIndex == i;
        return Tab(
          height: 44,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                tab.icon,
                size: 16,
                color: isActive
                    ? const Color(0xFFfeb800)
                    : Colors.white.withOpacity(0.45),
              ),
              const SizedBox(width: 7),
              Text(
                tab.label,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  color: isActive
                      ? const Color(0xFFfeb800)
                      : Colors.white.withOpacity(0.45),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

// ── Tab content ────────────────────────────────────────────────────────────────

class _TabContent extends StatelessWidget {
  final SkillTab tab;
  final bool isMobile;
  final double screenWidth;

  const _TabContent({
    super.key,
    required this.tab,
    required this.isMobile,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = screenWidth >= 1000;

    // Build a flat delay map: card → animation delay ms
    final Map<SkillCard, int> delayMap = {};
    int counter = 0;
    for (final group in tab.groups) {
      for (final card in group.cards) {
        delayMap[card] = counter * 80;
        counter++;
      }
    }

    // ── On desktop: pair consecutive single-card groups side by side ──────
    // Strategy: walk through groups and collect "display rows".
    // A display row is either:
    //   • A normal group (2+ cards) rendered full-width
    //   • A pair of two consecutive single-card groups rendered 50/50
    //   • A lone single-card group that had no partner (rendered full-width)

    final List<Widget> rows = [];

    if (!isDesktop) {
      // Mobile / tablet: render each group independently, full width
      for (final group in tab.groups) {
        rows.add(_buildGroupLabel(group.groupTitle));
        for (final card in group.cards) {
          rows.add(
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: SkillCardWidget(
                card: card,
                animationDelay: delayMap[card]!,
              ),
            ),
          );
        }
        rows.add(const SizedBox(height: 8));
      }
    } else {
      // Desktop: pair single-card groups
      int i = 0;
      while (i < tab.groups.length) {
        final current = tab.groups[i];

        if (current.cards.length == 1 && i + 1 < tab.groups.length) {
          // Pair this single-card group with the next group (any size)
          final next = tab.groups[i + 1];

          // Check if a third single-card group can fill the third column
          final bool hasNextLater =
              next.cards.length == 1 &&
              i + 2 < tab.groups.length &&
              tab.groups[i + 2].cards.length == 1;
          final SkillGroup? nextLater = hasNextLater ? tab.groups[i + 2] : null;

          rows.add(
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildGroupLabel(current.groupTitle),
                        SkillCardWidget(
                          card: current.cards.first,
                          animationDelay: delayMap[current.cards.first]!,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: (next.cards.length == 1) ? 1 : 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildGroupLabel(next.groupTitle),
                        if (next.cards.length == 1)
                          SkillCardWidget(
                            card: next.cards.first,
                            animationDelay: delayMap[next.cards.first]!,
                          )
                        else
                          ...() {
                            final List<Widget> cardRows = [];
                            for (int j = 0; j < next.cards.length; j += 2) {
                              final slice = next.cards.sublist(
                                j,
                                (j + 2).clamp(0, next.cards.length),
                              );
                              cardRows.add(
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      for (
                                        int k = 0;
                                        k < slice.length;
                                        k++
                                      ) ...[
                                        Expanded(
                                          child: SkillCardWidget(
                                            card: slice[k],
                                            animationDelay: delayMap[slice[k]]!,
                                          ),
                                        ),
                                        if (k < slice.length - 1)
                                          const SizedBox(width: 12),
                                      ],
                                      if (slice.length == 1) ...[
                                        const SizedBox(width: 12),
                                        const Expanded(child: SizedBox()),
                                      ],
                                    ],
                                  ),
                                ),
                              );
                            }
                            return cardRows;
                          }(),
                      ],
                    ),
                  ),
                  // Third column: nextLater if all three are single-card groups
                  if (nextLater != null) ...[
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildGroupLabel(nextLater.groupTitle),
                          SkillCardWidget(
                            card: nextLater.cards.first,
                            animationDelay: delayMap[nextLater.cards.first]!,
                          ),
                        ],
                      ),
                    ),
                  ] else if (next.cards.length == 1) ...[
                    // next is single but no valid third group — keep spacing
                    const SizedBox(width: 12),
                    const Expanded(flex: 1, child: SizedBox()),
                  ],
                ],
              ),
            ),
          );

          // Advance past all consumed groups
          i += hasNextLater ? 3 : 2;
        } else {
          // Normal group: render full-width with its own card grid
          rows.add(_buildGroupLabel(current.groupTitle));
          final List<Widget> cardWidgets = current.cards.map((card) {
            return SkillCardWidget(card: card, animationDelay: delayMap[card]!);
          }).toList();

          // Lay cards in rows of up to 3 columns
          const int cols = 3;
          for (int j = 0; j < cardWidgets.length; j += cols) {
            final slice = cardWidgets.sublist(
              j,
              (j + cols).clamp(0, cardWidgets.length),
            );
            rows.add(
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int k = 0; k < slice.length; k++) ...[
                      Expanded(child: slice[k]),
                      if (k < slice.length - 1) const SizedBox(width: 12),
                    ],
                    // Empty slots
                    for (int k = slice.length; k < cols; k++) ...[
                      const SizedBox(width: 12),
                      const Expanded(child: SizedBox()),
                    ],
                  ],
                ),
              ),
            );
          }
          rows.add(const SizedBox(height: 8));
          i++;
        }
      }
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: rows);
  }

  Widget _buildGroupLabel(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 4),
      child: Row(
        children: [
          Container(
            width: 3,
            height: 16,
            decoration: BoxDecoration(
              color: const Color(0xFFfeb800),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.5),
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}
