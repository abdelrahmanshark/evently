import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/ui/home_view/tab/map_tab/view_model/map_tab_view_model.dart';
import 'package:evently/ui/home_view/tab/map_tab/widget/map_events_list.dart';
import 'package:evently/ui/home_view/tab/map_tab/widget/map_message_card.dart';
import 'package:evently/ui/widget/app_loading_indicator.dart';
import 'package:evently/ui/widget/fade_in.dart';
import 'package:evently/ui/widget/retry_view.dart';
import 'package:evently/utils/failure_messages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Shows the loading, error, empty, or list state of the map events.
class MapEventsSection extends StatelessWidget {
  const MapEventsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    final MapTabViewModel viewModel = context.watch<MapTabViewModel>();
    if (viewModel.isLoading) {
      return const FadeIn(
        key: ValueKey('loading'),
        child: AppLoadingIndicator(),
      );
    }
    if (viewModel.failure != null) {
      return FadeIn(
        key: const ValueKey('failure'),
        child: MapMessageCard(
          child: RetryView(
            message: FailureMessages.messageFor(text, viewModel.failure!),
            onRefresh: viewModel.watchEvents,
          ),
        ),
      );
    }
    if (viewModel.events.isEmpty) {
      return FadeIn(
        key: const ValueKey('empty'),
        child: MapMessageCard(
          child: Text(
            text.no_events_found,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
      );
    }
    return FadeIn(
      key: const ValueKey('content'),
      child: MapEventsList(
        events: viewModel.events,
        addresses: viewModel.addresses,
        selectedIndex: viewModel.selectedIndex,
        onEventTap: viewModel.selectEvent,
      ),
    );
  }
}
