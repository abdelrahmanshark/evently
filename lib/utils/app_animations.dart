import 'package:flutter/animation.dart';

class AppAnimations {
  /// Tap feedback.
  static const Duration press = Duration(milliseconds: 120);

  /// Tab, section, and state switches.
  static const Duration fast = Duration(milliseconds: 220);

  /// List item shrink/grow.
  static const Duration listMove = Duration(milliseconds: 300);

  /// Icon swaps.
  static const Duration iconSwitch = Duration(milliseconds: 200);

  /// Programmatic page jumps (used with [pageJumpCurve]).
  static const Duration pageJump = Duration(milliseconds: 300);

  /// Full splash logo animation (bloom, then wordmark reveal).
  static const Duration splash = Duration(milliseconds: 1600);

  /// Pause on the finished splash before leaving it.
  static const Duration splashHold = Duration(milliseconds: 400);

  static const Curve curve = Curves.easeOutCubic;
  static const Curve pageJumpCurve = Curves.easeInOut;
  static const double pressedScale = 0.97;
}
