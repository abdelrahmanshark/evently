import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/app_failure.dart';
import 'package:evently/providers/my_user_provider.dart';
import 'package:evently/ui/auth/cubit/auth_form_state.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_messenger.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/failure_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Shows auth errors and, on success, stores the user and opens home.
/// [C] is the auth cubit type (login or register).
class AuthStateListener<C extends StateStreamable<AuthFormState>>
    extends StatelessWidget {
  const AuthStateListener({
    super.key,
    required this.successMessage,
    required this.child,
  });

  final String successMessage;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<C, AuthFormState>(
      listener: (context, state) {
        final AppFailure? failure = state.failure;
        if (failure != null && failure != AppFailure.cancelled) {
          AppMessenger.showSnackBar(
            FailureMessages.messageFor(AppLocalizations.of(context)!, failure),
            backgroundColor: AppColors.redColor,
          );
        }
        if (state.user != null) {
          context.read<MyUserProvider>().updateUser(state.user!);
          AppMessenger.showSnackBar(successMessage);
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.homeRouteName,
            (route) => false,
          );
        }
      },
      child: child,
    );
  }
}
