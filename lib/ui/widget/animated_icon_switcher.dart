import 'package:evently/utils/app_animations.dart';
import 'package:flutter/material.dart';

class AnimatedIconSwitcher extends StatelessWidget {
  const AnimatedIconSwitcher({super.key, required this.child});

  /// Must carry a changing ValueKey, e.g. `Icon(..., key: ValueKey(isFavorite))`.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: AppAnimations.iconSwitch,
      transitionBuilder: (child, animation) => ScaleTransition(
        scale: animation,
        child: FadeTransition(opacity: animation, child: child),
      ),
      child: child,
    );
  }
}
