import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/ui/auth/register_view/cubit/register_cubit.dart';
import 'package:evently/ui/auth/widget/auth_state_listener.dart';
import 'package:evently/ui/auth/widget/auth_switch_row.dart';
import 'package:evently/ui/widget/custom_elevated_button.dart';
import 'package:evently/ui/widget/custom_text_form_field.dart';
import 'package:evently/ui/widget/fill_or_scroll_view.dart';
import 'package:evently/ui/widget/language_toggle.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:evently/utils/app_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// Validates the form, then asks the cubit to create the account.
  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<RegisterCubit>().register();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    final RegisterCubit cubit = context.read<RegisterCubit>();
    final bool isLoading = context.select<RegisterCubit, bool>(
      (cubit) => cubit.state.isLoading,
    );
    return AuthStateListener<RegisterCubit>(
      successMessage: text.register_Successfully,
      child: FillOrScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            spacing: 12,
            children: [
              Image.asset(
                AppAssets.eventlyLogo,
                height: MediaQuery.sizeOf(context).height * .2,
              ),
              CustomTextFormField(
                hintText: text.name,
                prefixIcon: Icons.person_outline,
                onChanged: cubit.onNameChanged,
                validator: (value) =>
                    AppValidators.required(value, text.please_enter_your_name),
              ),
              CustomTextFormField(
                hintText: text.email,
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                onChanged: cubit.onEmailChanged,
                validator: (value) => AppValidators.email(value, text),
              ),
              CustomTextFormField(
                hintText: text.password,
                prefixIcon: Icons.lock,
                isPassword: true,
                onChanged: cubit.onPasswordChanged,
                validator: (value) => AppValidators.password(value, text),
              ),
              CustomTextFormField(
                hintText: text.re_password,
                prefixIcon: Icons.lock,
                isPassword: true,
                validator: (value) =>
                    AppValidators.confirmPassword(value, cubit.password, text),
              ),
              SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  onPressed: _submit,
                  isLoading: isLoading,
                  child: Text(text.create_account, style: AppStyles.whiteMed20),
                ),
              ),
              AuthSwitchRow(
                message: text.already_have_account,
                actionText: text.login,
                onPressed: () => Navigator.pop(context),
              ),
              const LanguageToggle(),
            ],
          ),
        ),
      ),
    );
  }
}
