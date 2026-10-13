import 'package:evently/di/injection.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/event.dart';
import 'package:evently/providers/my_user_provider.dart';
import 'package:evently/ui/home_view/my_events_view/cubit/my_events_cubit.dart';
import 'package:evently/ui/home_view/my_events_view/cubit/my_events_state.dart';
import 'package:evently/ui/home_view/widget/events_list.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyEventsView extends StatelessWidget {
  const MyEventsView({super.key});

  /// Opens the details screen of [event].
  void _openDetails(BuildContext context, Event event) {
    Navigator.pushNamed(
      context,
      AppRoutes.eventDetailsRouteName,
      arguments: event,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MyEventsCubit>()
        // `..` (cascade) creates the cubit and starts listening in one expression.
        ..watchMyEvents(context.read<MyUserProvider>().currentUser!.id),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            AppLocalizations.of(context)!.my_event,
            style: AppStyles.primaryMed20,
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppColors.primaryColor),
        ),
        body: BlocBuilder<MyEventsCubit, MyEventsState>(
          builder: (context, state) => EventsList(
            events: state.events,
            isLoading: state.isLoading,
            failure: state.failure,
            onRetry: context.read<MyEventsCubit>().retry,
            showFavoriteButton: false,
            onEventTap: (event) => _openDetails(context, event),
          ),
        ),
      ),
    );
  }
}
