import 'package:evently/di/injection.dart';
import 'package:evently/ui/auth/login_view/cubit/login_cubit.dart';
import 'package:evently/ui/auth/login_view/widget/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LoginCubit>(),
      child: const Scaffold(body: SafeArea(child: LoginForm())),
    );
  }
}
