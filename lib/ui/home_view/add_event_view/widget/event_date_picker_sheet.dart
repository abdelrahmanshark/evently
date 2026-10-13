import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:evently/providers/app_local_provider.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventDatePickerSheet extends StatelessWidget {
  const EventDatePickerSheet({
    super.key,
    required this.initialDate,
    required this.onDateChanged,
  });

  final DateTime initialDate;
  final ValueChanged<DateTime> onDateChanged;

  @override
  Widget build(BuildContext context) {
    return EasyDateTimeLine(
      initialDate: initialDate,
      locale: context.read<AppLocalProvider>().appLocal,
      onDateChange: onDateChanged,
      activeColor: AppColors.primaryColor,
      timeLineProps: const EasyTimeLineProps(decoration: BoxDecoration()),
      dayProps: const EasyDayProps(
        inactiveDayStyle: DayStyle(
          monthStrStyle: AppStyles.primaryBold16,
          dayStrStyle: AppStyles.primaryBold16,
        ),
        activeDayStyle: DayStyle(
          monthStrStyle: AppStyles.blackBold16,
          dayStrStyle: AppStyles.blackBold16,
        ),
      ),
      headerProps: const EasyHeaderProps(
        monthPickerType: MonthPickerType.switcher,
        monthStyle: AppStyles.primaryBold16,
        selectedDateStyle: AppStyles.primaryBold16,
      ),
    );
  }
}
