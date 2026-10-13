import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/ui/auth/login_view/cubit/login_cubit.dart';
import 'package:evently/ui/auth/widget/auth_state_listener.dart';
import 'package:evently/ui/auth/widget/auth_switch_row.dart';
import 'package:evently/ui/auth/widget/or_divider.dart';
import 'package:evently/ui/widget/custom_elevated_button.dart';
import 'package:evently/ui/widget/custom_text_form_field.dart';
import 'package:evently/ui/widget/fill_or_scroll_view.dart';
import 'package:evently/ui/widget/language_toggle.dart';
import 'package:evently/ui/widget/theme_toggle.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:evently/utils/app_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// Validates the form, then asks the cubit to sign in.
  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<LoginCubit>().login();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    final LoginCubit cubit = context.read<LoginCubit>();
    final bool isLoading = context.select<LoginCubit, bool>(
      (cubit) => cubit.state.isLoading,
    );
    return AuthStateListener<LoginCubit>(
      successMessage: text.login_Successfully,
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
              SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  onPressed: _submit,
                  isLoading: isLoading,
                  child: Text(text.login, style: AppStyles.whiteMed20),
                ),
              ),
              AuthSwitchRow(
                message: text.dont_have_account,
                actionText: text.create_account,
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoutes.registerRouteName),
              ),
              OrDivider(text: text.or),
              SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  onPressed: cubit.loginWithGoogle,
                  isLoading: isLoading,
                  backGroundColor: Colors.transparent,
                  borderColor: AppColors.primaryColor,
                  child: Text(
                    text.login_with_google,
                    style: AppStyles.primaryMed20,
                  ),
                ),
              ),
              const LanguageToggle(),
              const ThemeToggle(),
            ],
          ),
        ),
      ),
    );
  }
}
