import 'package:evently/models/ob_page.dart';
import 'package:flutter/material.dart';

class IntroPageContent extends StatelessWidget {
  const IntroPageContent({super.key, required this.page});

  final ObPage page;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(child: Image.asset(page.image)),
        Text(page.title, style: textTheme.headlineLarge),
        const SizedBox(height: 10),
        Text(page.body, style: textTheme.bodyMedium),
        const SizedBox(height: 10),
      ],
    );
  }
}
