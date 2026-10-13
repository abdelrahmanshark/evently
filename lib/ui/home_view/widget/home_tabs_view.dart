import 'package:evently/utils/app_animations.dart';
import 'package:flutter/material.dart';

/// Keeps every visited tab alive and builds each tab on its first visit.
class HomeTabsView extends StatefulWidget {
  const HomeTabsView({
    super.key,
    required this.selectedIndex,
    required this.tabs,
  });

  final int selectedIndex;
  final List<Widget> tabs;

  @override
  State<HomeTabsView> createState() => _HomeTabsViewState();
}

class _HomeTabsViewState extends State<HomeTabsView> {
  final Set<int> _visitedTabs = {};

  @override
  Widget build(BuildContext context) {
    _visitedTabs.add(widget.selectedIndex);
    return IndexedStack(
      index: widget.selectedIndex,
      children: [
        // Collection `for` builds one child per tab; unvisited tabs stay empty (lazy).
        for (int i = 0; i < widget.tabs.length; i++)
          TickerMode(
            enabled: i == widget.selectedIndex,
            child: ExcludeFocus(
              excluding: i != widget.selectedIndex,
              child: AnimatedOpacity(
                opacity: i == widget.selectedIndex ? 1 : 0,
                duration: AppAnimations.fast,
                curve: AppAnimations.curve,
                child: _visitedTabs.contains(i)
                    ? widget.tabs[i]
                    : const SizedBox.shrink(),
              ),
            ),
          ),
      ],
    );
  }
}
