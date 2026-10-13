import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';

/// Profile drop-down that highlights the selected option in the primary color.
class SettingsDropDown<T> extends StatelessWidget {
  const SettingsDropDown({
    super.key,
    required this.selectedValue,
    required this.options,
    required this.onSelected,
  });

  final T selectedValue;

  /// Each value mapped to its label.
  final Map<T, String> options;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size screenSize = MediaQuery.sizeOf(context);
    final OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.primaryColor),
    );
    return DropdownMenu<T>(
      // A new key per value resets the field text when the value changes elsewhere.
      key: ValueKey(selectedValue),
      initialSelection: selectedValue,
      width: double.infinity,
      textStyle: AppStyles.primaryBold20,
      inputDecorationTheme: InputDecorationThemeData(
        border: border,
        enabledBorder: border,
      ),
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(theme.cardColor),
        fixedSize: WidgetStatePropertyAll(
          Size(screenSize.width, screenSize.height * .15),
        ),
      ),
      onSelected: (value) {
        if (value != null) onSelected(value);
      },
      trailingIcon: const Icon(
        Icons.arrow_drop_down,
        color: AppColors.primaryColor,
        size: 40,
      ),
      selectedTrailingIcon: const Icon(
        Icons.arrow_drop_up,
        color: AppColors.primaryColor,
        size: 40,
      ),
      dropdownMenuEntries: [
        for (final MapEntry<T, String> option in options.entries)
          DropdownMenuEntry<T>(
            value: option.key,
            label: option.value,
            labelWidget: Text(
              option.value,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: option.key == selectedValue
                    ? AppColors.primaryColor
                    : theme.canvasColor,
              ),
            ),
          ),
      ],
    );
  }
}
