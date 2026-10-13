import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/ui/home_view/add_event_view/widget/time_wheel.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';

/// Hour / minute / am-pm wheels. Pops with the picked [TimeOfDay].
class EventTimePickerSheet extends StatefulWidget {
  const EventTimePickerSheet({super.key});

  @override
  State<EventTimePickerSheet> createState() => _EventTimePickerSheetState();
}

class _EventTimePickerSheetState extends State<EventTimePickerSheet> {
  /// 0 shows as 12.
  int _hour = 0;
  int _minute = 0;
  bool _isPm = false;

  /// Closes the sheet with the selected time.
  void _confirm() {
    Navigator.pop(
      context,
      TimeOfDay(hour: _hour + (_isPm ? 12 : 0), minute: _minute),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.ltr,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TimeWheel(
          itemCount: 12,
          labelOf: (index) => index == 0 ? '12' : '$index',
          onChanged: (index) => _hour = index,
        ),
        const SizedBox(width: 15),
        TimeWheel(
          itemCount: 60,
          labelOf: (index) => index.toString().padLeft(2, '0'),
          onChanged: (index) => _minute = index,
        ),
        const SizedBox(width: 15),
        TimeWheel(
          itemCount: 2,
          looping: false,
          labelOf: (index) => index == 0 ? 'am' : 'pm',
          onChanged: (index) => _isPm = index == 1,
        ),
        const SizedBox(width: 50),
        TextButton(
          onPressed: _confirm,
          child: Text(
            AppLocalizations.of(context)!.done,
            style: AppStyles.primaryBold20,
          ),
        ),
      ],
    );
  }
}
