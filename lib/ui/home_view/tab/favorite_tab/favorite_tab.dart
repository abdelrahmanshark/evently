import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/ui/home_view/cubit/favorites_cubit.dart';
import 'package:evently/ui/home_view/cubit/favorites_state.dart';
import 'package:evently/ui/home_view/widget/events_list.dart';
import 'package:evently/ui/widget/custom_text_form_field.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoritesCubit cubit = context.read<FavoritesCubit>();
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              CustomTextFormField(
                hintText: AppLocalizations.of(context)!.search_for_events,
                prefixIcon: Icons.search,
                prefixIconColor: AppColors.primaryColor,
                outLineBorderColor: AppColors.primaryColor,
                onChanged: cubit.onSearchChanged,
              ),
              Expanded(
                child: BlocBuilder<FavoritesCubit, FavoritesState>(
                  builder: (context, state) => EventsList(
                    events: state.visibleFavorites,
                    isLoading: state.isLoading,
                    failure: state.failure,
                    onRetry: cubit.retry,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
