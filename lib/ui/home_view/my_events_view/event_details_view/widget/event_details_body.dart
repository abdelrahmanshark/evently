import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/event.dart';
import 'package:evently/models/place_address.dart';
import 'package:evently/ui/home_view/my_events_view/event_details_view/cubit/event_details_cubit.dart';
import 'package:evently/ui/home_view/my_events_view/event_details_view/cubit/event_details_state.dart';
import 'package:evently/ui/home_view/my_events_view/event_details_view/widget/event_info_tile.dart';
import 'package:evently/ui/home_view/my_events_view/event_details_view/widget/event_location_map.dart';
import 'package:evently/ui/home_view/widget/event_category_image.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:evently/utils/date_formats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Scrollable details of the event: image, title, date, location, map, and description.
class EventDetailsBody extends StatelessWidget {
  const EventDetailsBody({super.key});

  static const double _spacing = 16;

  /// Returns the location text for the current address state.
  String _locationText(AppLocalizations text, EventDetailsState state) {
    if (state.isAddressLoading) return text.loading;
    final PlaceAddress? address = state.address;
    if (address == null) return text.unknown_location;
    return '${address.city} , ${address.country}';
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return BlocBuilder<EventDetailsCubit, EventDetailsState>(
      builder: (context, state) {
        final Event event = state.event;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(_spacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: _spacing,
            children: [
              EventCategoryImage(categoryId: event.categoryId),
              Text(event.title, style: AppStyles.primaryMed24),
              EventInfoTile(
                iconAsset: AppAssets.calendarDaysIcon,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    Text(
                      DateFormats.longDate(event.date),
                      style: AppStyles.primaryMed16,
                    ),
                    Text(event.time, style: textTheme.bodyMedium),
                  ],
                ),
              ),
              EventInfoTile(
                iconAsset: AppAssets.locateIcon,
                trailing: SvgPicture.asset(
                  AppAssets.arrowRightIcon,
                  // Points to the end side in both reading directions.
                  matchTextDirection: true,
                ),
                child: Text(
                  _locationText(text, state),
                  style: AppStyles.primaryMed16,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              EventLocationMap(
                location: LatLng(event.latitude, event.longitude),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text(text.description, style: textTheme.bodyMedium),
                  Text(event.description, style: textTheme.bodyMedium),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
