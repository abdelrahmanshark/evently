import 'package:evently/ui/home_view/widget/event_category_art.dart';
import 'package:flutter/material.dart';

/// Rounded cover art of the category with [categoryId].
class EventCategoryImage extends StatelessWidget {
  const EventCategoryImage({super.key, required this.categoryId});

  final String categoryId;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * .25,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: EventCategoryArt(categoryId: categoryId),
      ),
    );
  }
}
