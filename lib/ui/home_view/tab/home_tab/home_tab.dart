import 'package:evently/di/injection.dart';
import 'package:evently/ui/home_view/tab/home_tab/cubit/home_tab_cubit.dart';
import 'package:evently/ui/home_view/tab/home_tab/cubit/home_tab_state.dart';
import 'package:evently/ui/home_view/tab/home_tab/widget/home_tab_app_bar_title.dart';
import 'package:evently/ui/home_view/tab/home_tab/widget/home_tab_header.dart';
import 'package:evently/ui/home_view/widget/events_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // `..` (cascade) creates the cubit and starts listening in one expression.
      create: (_) => getIt<HomeTabCubit>()..watchEvents(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const HomeTabAppBarTitle(),
        ),
        body: Column(
          children: [
            const HomeTabHeader(),
            Expanded(
              child: BlocBuilder<HomeTabCubit, HomeTabState>(
                builder: (context, state) => EventsList(
                  events: state.visibleEvents,
                  isLoading: state.isLoading,
                  failure: state.failure,
                  onRetry: context.read<HomeTabCubit>().watchEvents,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
