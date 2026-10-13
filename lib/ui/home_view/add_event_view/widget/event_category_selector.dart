import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/event_category.dart';
import 'package:evently/ui/home_view/add_event_view/cubit/add_event_cubit.dart';
import 'package:evently/ui/home_view/widget/event_category_chip.dart';
import 'package:evently/ui/widget/pressable_scale.dart';
import 'package:evently/utils/event_category_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Horizontal list of category chips.
class EventCategorySelector extends StatelessWidget {
  const EventCategorySelector({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    final AddEventCubit cubit = context.read<AddEventCubit>();
    final int selectedIndex = context.select<AddEventCubit, int>(
      (cubit) => cubit.state.selectedCategoryIndex,
    );
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.07,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: EventCategory.all.length,
        separatorBuilder: (context, index) => const SizedBox(width: 17),
        itemBuilder: (context, index) => PressableScale(
          child: GestureDetector(
            onTap: () => cubit.selectCategory(index),
            child: EventCategoryChip(
              name: EventCategoryNames.nameOf(
                text,
                EventCategory.all[index].id,
              ),
              icon: EventCategory.all[index].icon,
              isSelected: selectedIndex == index,
              isAddEvent: true,
            ),
          ),
        ),
      ),
    );
  }
}
