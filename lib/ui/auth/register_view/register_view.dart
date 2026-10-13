import 'package:evently/di/injection.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/ui/auth/register_view/cubit/register_cubit.dart';
import 'package:evently/ui/auth/register_view/widget/register_form.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RegisterCubit>(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            AppLocalizations.of(context)!.register,
            style: AppStyles.primaryMed20,
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppColors.primaryColor),
        ),
        body: const SafeArea(child: RegisterForm()),
      ),
    );
  }
}
