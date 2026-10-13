import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/place_address.dart';
import 'package:evently/ui/home_view/add_event_view/view_model/pick_location_view_model.dart';
import 'package:evently/ui/widget/custom_elevated_button.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Shows the picked address and opens the map to pick a location.
class EventLocationButton extends StatelessWidget {
  const EventLocationButton({super.key});

  /// Opens the map screen to pick the event location.
  void _openMap(BuildContext context, PickLocationViewModel viewModel) {
    // Unfocusing clears the focus history, so the keyboard doesn't reopen when the map closes.
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.pushNamed(
      context,
      AppRoutes.eventMapRouteName,
      arguments: viewModel,
    );
  }

  @override
  Widget build(BuildContext context) {
    final PickLocationViewModel viewModel = context
        .watch<PickLocationViewModel>();
    final PlaceAddress? address = viewModel.address;
    return CustomElevatedButton(
      backGroundColor: Colors.transparent,
      borderColor: AppColors.primaryColor,
      onPressed: () => _openMap(context, viewModel),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.gps_fixed, color: Theme.of(context).cardColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              address == null
                  ? AppLocalizations.of(context)!.tap_on_location_to_select
                  : '${address.country} , ${address.city}',
              style: AppStyles.primaryMed16,
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_sharp,
            color: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}
