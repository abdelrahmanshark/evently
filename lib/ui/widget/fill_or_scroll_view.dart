import 'package:flutter/material.dart';

/// Stretches [child] to the full available height when it fits, and scrolls
/// it on small screens or while the keyboard takes space.
///
/// Spread the child's items with `MainAxisAlignment` (for example
/// `spaceBetween`), not `Spacer` or `Expanded`, because the height is unbounded
/// once the content scrolls.
class FillOrScrollView extends StatelessWidget {
  const FillOrScrollView({
    super.key,
    required this.child,
    this.padding = EdgeInsets.zero,
  });

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        padding: padding,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: (constraints.maxHeight - padding.vertical).clamp(
              0,
              double.infinity,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
