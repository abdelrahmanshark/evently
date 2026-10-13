import 'package:evently/utils/app_colors.dart';
import 'package:flutter/material.dart';

/// Card over the map that shows a message (empty or error) instead of the events.
class MapMessageCard extends StatelessWidget {
  const MapMessageCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primaryColor),
      ),
      child: child,
    );
  }
}
