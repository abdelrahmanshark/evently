import 'package:evently/models/event.dart';
import 'package:evently/ui/home_view/widget/event_category_art.dart';
import 'package:evently/ui/widget/pressable_scale.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:evently/utils/date_formats.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.event, this.trailing, this.onTap});

  final Event event;

  /// Shown after the title (e.g. a favorite button). The title is centered when null.
  final Widget? trailing;

  /// The card has no tap feedback when null.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final BoxDecoration badgeDecoration = BoxDecoration(
      color: theme.cardColor,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: AppColors.primaryColor, width: 2),
    );
    final BorderRadius cardRadius = BorderRadius.circular(16);
    final Widget card = Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      height: MediaQuery.sizeOf(context).height * .3,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: cardRadius),
      // Painted above the art so the border stays visible.
      foregroundDecoration: BoxDecoration(
        borderRadius: cardRadius,
        border: Border.all(color: AppColors.primaryColor, width: 2),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          EventCategoryArt(categoryId: event.categoryId),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                decoration: badgeDecoration,
                child: Column(
                  children: [
                    Text(
                      event.date.day.toString(),
                      style: AppStyles.primaryBold20,
                    ),
                    Text(
                      DateFormats.shortMonth(event.date),
                      style: AppStyles.primaryBold14,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                height: 55,
                padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 9),
                decoration: badgeDecoration,
                child: Row(
                  mainAxisAlignment: trailing == null
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        event.title,
                        style: theme.textTheme.bodySmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (trailing != null) trailing!,
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
    if (onTap == null) return card;
    return PressableScale(
      child: GestureDetector(onTap: onTap, child: card),
    );
  }
}
