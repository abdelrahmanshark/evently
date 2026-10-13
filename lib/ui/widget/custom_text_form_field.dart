import 'package:evently/ui/widget/animated_icon_switcher.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.initialValue,
    this.prefixIcon,
    this.prefixIconColor,
    this.outLineBorderColor,
    this.validator,
    this.onChanged,
    this.maxLines = 1,
    this.isPassword = false,
    this.keyboardType,
  });

  final String hintText;

  /// Text shown when the field is first built (e.g. when editing).
  final String? initialValue;
  final IconData? prefixIcon;
  final Color? prefixIconColor;
  final Color? outLineBorderColor;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final int maxLines;

  /// Hides the text and shows a visibility toggle.
  final bool isPassword;
  final TextInputType? keyboardType;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isObscured = true;

  /// Shows or hides the password text.
  void _toggleObscured() {
    setState(() => _isObscured = !_isObscured);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: widget.outLineBorderColor ?? theme.disabledColor,
        width: 2,
      ),
    );
    final OutlineInputBorder errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.redColor, width: 2),
    );
    return TextFormField(
      initialValue: widget.initialValue,
      maxLines: widget.isPassword ? 1 : widget.maxLines,
      keyboardType: widget.keyboardType,
      textAlignVertical: TextAlignVertical.top,
      obscureText: widget.isPassword && _isObscured,
      style: theme.textTheme.bodyLarge,
      cursorColor: AppColors.primaryColor,
      validator: widget.validator,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        enabledBorder: border,
        focusedBorder: border,
        errorBorder: errorBorder,
        focusedErrorBorder: errorBorder,
        hintText: widget.hintText,
        hintStyle: theme.textTheme.labelSmall,
        errorStyle: AppStyles.redMed16,
        prefixIcon: widget.prefixIcon == null
            ? null
            : Icon(
                widget.prefixIcon,
                color: widget.prefixIconColor ?? theme.disabledColor,
              ),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: _toggleObscured,
                icon: AnimatedIconSwitcher(
                  child: Icon(
                    _isObscured
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    key: ValueKey(_isObscured),
                    color: theme.disabledColor,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
