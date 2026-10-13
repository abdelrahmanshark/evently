import 'package:evently/ui/home_view/my_events_view/event_details_view/cubit/event_details_cubit.dart';
import 'package:evently/ui/home_view/my_events_view/event_details_view/widget/delete_event_dialog.dart';
import 'package:evently/ui/widget/animated_icon_switcher.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Edit and delete buttons of the event details app bar.
class EventDetailsActions extends StatelessWidget {
  const EventDetailsActions({super.key});

  /// Opens the edit screen with the current event.
  void _openEdit(BuildContext context) {
    Navigator.pushNamed(
      context,
      AppRoutes.editEventRouteName,
      arguments: context.read<EventDetailsCubit>().state.event,
    );
  }

  /// Asks for confirmation, then deletes the event.
  Future<void> _confirmDelete(BuildContext context) async {
    final EventDetailsCubit cubit = context.read<EventDetailsCubit>();
    final bool? isConfirmed = await showDialog<bool>(
      context: context,
      builder: (_) => const DeleteEventDialog(),
    );
    if (isConfirmed == true) cubit.deleteEvent();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDeleting = context.select<EventDetailsCubit, bool>(
      (cubit) => cubit.state.isDeleting,
    );
    return Row(
      children: [
        IconButton(
          onPressed: isDeleting ? null : () => _openEdit(context),
          icon: SvgPicture.asset(AppAssets.editIcon),
        ),
        IconButton(
          onPressed: isDeleting ? null : () => _confirmDelete(context),
          icon: AnimatedIconSwitcher(
            child: isDeleting
                ? const SizedBox(
                    key: ValueKey(true),
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: AppColors.redColor,
                      strokeWidth: 2.5,
                    ),
                  )
                : SvgPicture.asset(
                    AppAssets.deleteIcon,
                    key: const ValueKey(false),
                  ),
          ),
        ),
      ],
    );
  }
}
