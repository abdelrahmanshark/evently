import 'package:evently/di/injection.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/event.dart';
import 'package:evently/ui/home_view/add_event_view/cubit/add_event_cubit.dart';
import 'package:evently/ui/home_view/add_event_view/view_model/pick_location_view_model.dart';
import 'package:evently/ui/home_view/add_event_view/widget/add_event_form.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

/// Creates a new event, or edits [eventToEdit] when it's passed.
class AddEventView extends StatelessWidget {
  const AddEventView({super.key, this.eventToEdit});

  final Event? eventToEdit;

  /// Creates the location view model, centered on the edited event or on the user.
  PickLocationViewModel _createLocationViewModel() {
    final PickLocationViewModel viewModel = getIt<PickLocationViewModel>();
    final Event? event = eventToEdit;
    if (event == null) {
      viewModel.locateUser();
    } else {
      viewModel.startAt(LatLng(event.latitude, event.longitude));
    }
    return viewModel;
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<AddEventCubit>(param1: eventToEdit),
        ),
        ChangeNotifierProvider(create: (_) => _createLocationViewModel()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            eventToEdit == null ? text.create_event : text.edit_event,
            style: AppStyles.primaryMed20,
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).cardColor,
        ),
        body: const AddEventForm(),
      ),
    );
  }
}
