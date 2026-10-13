import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/event_category.dart';
import 'package:evently/providers/my_user_provider.dart';
import 'package:evently/ui/home_view/add_event_view/cubit/add_event_cubit.dart';
import 'package:evently/ui/home_view/add_event_view/cubit/add_event_state.dart';
import 'package:evently/ui/home_view/add_event_view/view_model/pick_location_view_model.dart';
import 'package:evently/ui/home_view/add_event_view/widget/event_category_selector.dart';
import 'package:evently/ui/home_view/add_event_view/widget/event_date_row.dart';
import 'package:evently/ui/home_view/add_event_view/widget/event_location_button.dart';
import 'package:evently/ui/home_view/add_event_view/widget/event_time_row.dart';
import 'package:evently/ui/home_view/widget/event_category_image.dart';
import 'package:evently/ui/widget/custom_elevated_button.dart';
import 'package:evently/ui/widget/custom_text_form_field.dart';
import 'package:evently/ui/widget/fill_or_scroll_view.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_messenger.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:evently/utils/app_validators.dart';
import 'package:evently/utils/failure_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddEventForm extends StatefulWidget {
  const AddEventForm({super.key});

  @override
  State<AddEventForm> createState() => _AddEventFormState();
}

class _AddEventFormState extends State<AddEventForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// Checks the date, time, location, and fields, then asks the cubit to save the event.
  void _submit() {
    final AppLocalizations text = AppLocalizations.of(context)!;
    final AddEventCubit cubit = context.read<AddEventCubit>();
    final LatLng? location = context
        .read<PickLocationViewModel>()
        .eventLocation;
    if (cubit.state.time == null) {
      AppMessenger.showSnackBar(
        text.please_enter_event_time,
        backgroundColor: AppColors.redColor,
      );
      return;
    }
    if (cubit.state.date == null) {
      AppMessenger.showSnackBar(
        text.please_enter_event_date,
        backgroundColor: AppColors.redColor,
      );
      return;
    }
    if (location == null) {
      AppMessenger.showSnackBar(
        text.please_select_event_location,
        backgroundColor: AppColors.redColor,
      );
      return;
    }
    if (!_formKey.currentState!.validate()) return;
    cubit.saveEvent(context.read<MyUserProvider>().currentUser!.id, location);
  }

  /// Closes the screen once saved, or shows the failure.
  void _onStateChanged(BuildContext context, AddEventState state) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    if (state.isSaved) {
      final bool isEditing = context.read<AddEventCubit>().isEditing;
      AppMessenger.showSnackBar(
        isEditing ? text.event_updated : text.event_added,
        backgroundColor: AppColors.primaryColor,
      );
      Navigator.pop(context);
    } else if (state.failure != null) {
      AppMessenger.showSnackBar(
        FailureMessages.messageFor(text, state.failure!),
        backgroundColor: AppColors.redColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final AddEventCubit cubit = context.read<AddEventCubit>();
    return BlocListener<AddEventCubit, AddEventState>(
      listenWhen: (previous, current) =>
          current.isSaved || current.failure != null,
      listener: _onStateChanged,
      child: FillOrScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocSelector<AddEventCubit, AddEventState, int>(
                selector: (state) => state.selectedCategoryIndex,
                builder: (context, selectedIndex) => EventCategoryImage(
                  categoryId: EventCategory.all[selectedIndex].id,
                ),
              ),
              const EventCategorySelector(),
              Text(text.title, style: textTheme.bodyMedium),
              CustomTextFormField(
                prefixIcon: Icons.edit_note_rounded,
                hintText: text.event_title,
                initialValue: cubit.eventToEdit?.title,
                onChanged: cubit.onTitleChanged,
                validator: (value) => AppValidators.required(
                  value,
                  text.please_enter_event_title,
                ),
              ),
              Text(text.description, style: textTheme.bodyMedium),
              CustomTextFormField(
                maxLines: 3,
                hintText: text.event_description,
                initialValue: cubit.eventToEdit?.description,
                onChanged: cubit.onDescriptionChanged,
                validator: (value) => AppValidators.required(
                  value,
                  text.please_enter_event_discription,
                ),
              ),
              const EventDateRow(),
              const EventTimeRow(),
              Text(text.location, style: textTheme.bodyMedium),
              const EventLocationButton(),
              BlocSelector<AddEventCubit, AddEventState, bool>(
                selector: (state) => state.isSaving,
                builder: (context, isSaving) => CustomElevatedButton(
                  onPressed: _submit,
                  isLoading: isSaving,
                  child: Text(
                    cubit.isEditing ? text.update_event : text.add_event,
                    style: AppStyles.whiteMed20,
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
