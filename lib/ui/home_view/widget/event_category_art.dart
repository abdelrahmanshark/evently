import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/event_category.dart';
import 'package:evently/utils/event_category_art_style.dart';
import 'package:evently/utils/event_category_names.dart';
import 'package:flutter/material.dart';

/// Category name and illustration on a theme-colored background. Fills its parent.
class EventCategoryArt extends StatelessWidget {
  const EventCategoryArt({super.key, required this.categoryId});

  final String categoryId;

  @override
  Widget build(BuildContext context) {
    final EventCategoryArtStyle style = Theme.of(
      context,
    ).extension<EventCategoryArtStyle>()!;
    final EventCategory category = EventCategory.byId(categoryId);
    return Container(
      color: style.backgroundColor,
      // The art is laid out on a fixed canvas, then scaled to fit; the
      // background color fills any leftover space.
      child: FittedBox(
        child: SizedBox.fromSize(
          size: EventCategory.artSize,
          child: Stack(
            children: [
              Positioned.fromRect(
                rect: category.nameRect,
                child: FittedBox(
                  child: Text(
                    EventCategoryNames.nameOf(
                      AppLocalizations.of(context)!,
                      category.id,
                    ),
                    style: style.nameStyle,
                  ),
                ),
              ),
              Positioned.fromRect(
                rect: category.illustrationRect,
                child: Image.asset(category.illustration, fit: BoxFit.fill),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
