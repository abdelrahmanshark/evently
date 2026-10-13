import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/ui/home_view/add_event_view/cubit/add_event_cubit.dart';
import 'package:evently/ui/home_view/add_event_view/widget/choose_date_or_time.dart';
import 'package:evently/ui/home_view/add_event_view/widget/event_time_picker_sheet.dart';
import 'package:evently/utils/date_formats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventTimeRow extends StatelessWidget {
  const EventTimeRow({super.key});

  /// Opens the time picker sheet and saves the picked time.
  Future<void> _openPicker(BuildContext context) async {
    // Unfocusing clears the focus history, so the keyboard doesn't reopen when the sheet closes.
    FocusManager.instance.primaryFocus?.unfocus();
    final AddEventCubit cubit = context.read<AddEventCubit>();
    final TimeOfDay? time = await showModalBottomSheet<TimeOfDay>(
      context: context,
      backgroundColor: Theme.of(context).canvasColor,
      builder: (_) => const EventTimePickerSheet(),
    );
    if (time != null) cubit.selectTime(time);
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    final TimeOfDay? time = context.select<AddEventCubit, TimeOfDay?>(
      (cubit) => cubit.state.time,
    );
    return ChooseDateOrTime(
      icon: Icons.watch_later_outlined,
      text: text.event_time,
      actionText: time == null
          ? text.choose_time
          : DateFormats.eventTime(time),
      onTap: () => _openPicker(context),
    );
  }
}
