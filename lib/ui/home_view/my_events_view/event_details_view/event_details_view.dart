import 'package:evently/di/injection.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/event.dart';
import 'package:evently/providers/my_user_provider.dart';
import 'package:evently/ui/home_view/my_events_view/event_details_view/cubit/event_details_cubit.dart';
import 'package:evently/ui/home_view/my_events_view/event_details_view/cubit/event_details_state.dart';
import 'package:evently/ui/home_view/my_events_view/event_details_view/widget/event_details_actions.dart';
import 'package:evently/ui/home_view/my_events_view/event_details_view/widget/event_details_body.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_messenger.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:evently/utils/failure_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventDetailsView extends StatelessWidget {
  const EventDetailsView({super.key, required this.event});

  final Event event;

  /// Closes the screen once the event is deleted, or shows the failure.
  void _onStateChanged(BuildContext context, EventDetailsState state) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    if (state.isDeleted) {
      AppMessenger.showSnackBar(
        text.event_deleted,
        backgroundColor: AppColors.primaryColor,
      );
      Navigator.pop(context);
    } else if (state.failure != null) {
      AppMessenger.showSnackBar(
        FailureMessages.messageFor(text, state.failure!),
        backgroundColor: AppColors.redColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EventDetailsCubit>(param1: event)
        // `..` (cascade) creates the cubit and starts listening in one expression.
        ..watchEvent(context.read<MyUserProvider>().currentUser!.id),
      child: BlocListener<EventDetailsCubit, EventDetailsState>(
        listenWhen: (previous, current) =>
            previous.isDeleted != current.isDeleted || current.failure != null,
        listener: _onStateChanged,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              AppLocalizations.of(context)!.event_details,
              style: AppStyles.primaryMed20,
            ),
            centerTitle: true,
            iconTheme: const IconThemeData(color: AppColors.primaryColor),
            actions: const [EventDetailsActions()],
          ),
          body: const EventDetailsBody(),
        ),
      ),
    );
  }
}
