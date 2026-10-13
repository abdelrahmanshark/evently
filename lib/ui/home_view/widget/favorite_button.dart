import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/event.dart';
import 'package:evently/ui/home_view/cubit/favorites_cubit.dart';
import 'package:evently/ui/home_view/cubit/favorites_state.dart';
import 'package:evently/ui/widget/animated_icon_switcher.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key, required this.event});

  final Event event;

  /// Toggles the favorite and shows a toast with the result.
  Future<void> _onPressed(BuildContext context) async {
    final AppLocalizations text = AppLocalizations.of(context)!;
    final bool isAdded = await context.read<FavoritesCubit>().toggleFavorite(
      event,
    );
    AppToast.show(
      isAdded ? text.event_added_to_favorite : text.event_removed_from_favorite,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FavoritesCubit, FavoritesState, bool>(
      selector: (state) => state.isFavorite(event.id),
      builder: (context, isFavorite) => IconButton(
        onPressed: () => _onPressed(context),
        icon: AnimatedIconSwitcher(
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            key: ValueKey(isFavorite),
            color: AppColors.primaryColor,
            size: 30,
          ),
        ),
      ),
    );
  }
}
