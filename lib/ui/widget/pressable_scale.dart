import 'package:evently/utils/app_animations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PressableScale extends StatefulWidget {
  const PressableScale({super.key, required this.child});

  final Widget child;

  @override
  State<PressableScale> createState() => _PressableScaleState();
}

class _PressableScaleState extends State<PressableScale> {
  bool _isPressed = false;
  Offset _downPosition = Offset.zero;

  /// Marks the child as pressed and remembers where the finger went down.
  void _onPointerDown(PointerDownEvent event) {
    _downPosition = event.position;
    setState(() => _isPressed = true);
  }

  /// Releases the press when the finger moves far enough to be a scroll.
  void _onPointerMove(PointerMoveEvent event) {
    final double distance = (event.position - _downPosition).distance;
    if (_isPressed && distance > kTouchSlop) {
      setState(() => _isPressed = false);
    }
  }

  /// Releases the press.
  void _release() {
    if (_isPressed) {
      setState(() => _isPressed = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Listener (not GestureDetector) so the child's own onTap is never delayed or stolen.
    return Listener(
      onPointerDown: _onPointerDown,
      onPointerMove: _onPointerMove,
      onPointerUp: (_) => _release(),
      onPointerCancel: (_) => _release(),
      child: AnimatedScale(
        scale: _isPressed ? AppAnimations.pressedScale : 1,
        duration: AppAnimations.press,
        curve: AppAnimations.curve,
        child: widget.child,
      ),
    );
  }
}
