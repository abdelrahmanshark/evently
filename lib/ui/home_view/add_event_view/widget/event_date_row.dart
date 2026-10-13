import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/ui/home_view/add_event_view/cubit/add_event_cubit.dart';
import 'package:evently/ui/home_view/add_event_view/widget/choose_date_or_time.dart';
import 'package:evently/ui/home_view/add_event_view/widget/event_date_picker_sheet.dart';
import 'package:evently/utils/date_formats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventDateRow extends StatelessWidget {
  const EventDateRow({super.key});

  /// Opens the date picker sheet; picked dates go straight to the cubit.
  void _openPicker(BuildContext context) {
    // Unfocusing clears the focus history, so the keyboard doesn't reopen when the sheet closes.
    FocusManager.instance.primaryFocus?.unfocus();
    final AddEventCubit cubit = context.read<AddEventCubit>();
    showModalBottomSheet<void>(
      context: context,
      builder: (_) => EventDatePickerSheet(
        initialDate: cubit.state.date ?? DateTime.now(),
        onDateChanged: cubit.selectDate,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    final DateTime? date = context.select<AddEventCubit, DateTime?>(
      (cubit) => cubit.state.date,
    );
    return ChooseDateOrTime(
      icon: Icons.calendar_month_outlined,
      text: text.event_date,
      actionText: date == null
          ? text.choose_date
          : DateFormats.eventDate(date),
      onTap: () => _openPicker(context),
    );
  }
}
