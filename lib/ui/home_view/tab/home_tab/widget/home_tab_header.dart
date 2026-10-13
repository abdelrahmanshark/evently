import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/event_category.dart';
import 'package:evently/ui/home_view/tab/home_tab/cubit/home_tab_cubit.dart';
import 'package:evently/ui/home_view/widget/event_category_chip.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:evently/utils/event_category_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Location line and the category filter tabs under the home app bar.
class HomeTabHeader extends StatelessWidget {
  const HomeTabHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppLocalizations text = AppLocalizations.of(context)!;
    final int selectedIndex = context.select<HomeTabCubit, int>(
      (cubit) => cubit.state.selectedIndex,
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.primaryColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Icon(Icons.location_on_outlined, color: AppColors.whiteColor),
              SizedBox(width: 5),
              Text('cairo , egypt', style: AppStyles.whiteMed14),
            ],
          ),
          DefaultTabController(
            length: EventCategory.all.length + 1,
            child: TabBar(
              isScrollable: true,
              dividerColor: Colors.transparent,
              indicatorColor: Colors.transparent,
              tabAlignment: TabAlignment.start,
              labelPadding: const EdgeInsets.symmetric(horizontal: 7),
              onTap: context.read<HomeTabCubit>().selectCategory,
              tabs: [
                EventCategoryChip(
                  name: text.all,
                  icon: Icons.explore_outlined,
                  isSelected: selectedIndex == 0,
                ),
                for (int i = 0; i < EventCategory.all.length; i++)
                  EventCategoryChip(
                    name: EventCategoryNames.nameOf(
                      text,
                      EventCategory.all[i].id,
                    ),
                    icon: EventCategory.all[i].icon,
                    isSelected: selectedIndex == i + 1,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
