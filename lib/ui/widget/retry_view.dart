import 'package:evently/utils/app_colors.dart';
import 'package:flutter/material.dart';

class RetryView extends StatelessWidget {
  const RetryView({super.key, required this.message, required this.onRefresh});

  final String message;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          IconButton(
            onPressed: onRefresh,
            icon: const Icon(
              Icons.refresh,
              color: AppColors.primaryColor,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}
