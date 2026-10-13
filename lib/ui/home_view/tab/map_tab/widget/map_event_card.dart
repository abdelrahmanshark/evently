import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/event.dart';
import 'package:evently/models/place_address.dart';
import 'package:evently/ui/home_view/widget/event_category_art.dart';
import 'package:evently/ui/widget/pressable_scale.dart';
import 'package:evently/utils/app_animations.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Event card on the map: category image, title, and location.
class MapEventCard extends StatelessWidget {
  const MapEventCard({
    super.key,
    required this.event,
    required this.address,
    required this.isAddressLoading,
    required this.isSelected,
    required this.onTap,
  });

  static const double width = 321;
  static const double height = 94;

  final Event event;

  /// Null when the address is loading or unknown.
  final PlaceAddress? address;
  final bool isAddressLoading;
  final bool isSelected;
  final VoidCallback onTap;

  /// Returns the location line text for the current address state.
  String _locationText(AppLocalizations text) {
    if (isAddressLoading) return text.loading;
    final PlaceAddress? address = this.address;
    if (address == null) return text.unknown_location;
    return '${address.city} , ${address.country}';
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle locationStyle = isSelected
        ? AppStyles.primaryMed14
        : theme.textTheme.titleSmall!;
    return PressableScale(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: AppAnimations.fast,
          curve: AppAnimations.curve,
          width: width,
          height: height,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.primaryColor),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor.withValues(
                  alpha: isSelected ? 0.4 : 0,
                ),
                blurRadius: 12,
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 138,
                  child: EventCategoryArt(categoryId: event.categoryId),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: AppStyles.primaryBold14,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppAssets.mapPinIcon,
                          width: 24,
                          height: 24,
                          colorFilter: ColorFilter.mode(
                            locationStyle.color!,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            _locationText(AppLocalizations.of(context)!),
                            style: locationStyle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
