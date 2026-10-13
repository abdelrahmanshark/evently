import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:evently/di/injection.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/my_user_provider.dart';
import 'package:evently/ui/home_view/cubit/favorites_cubit.dart';
import 'package:evently/ui/home_view/tab/favorite_tab/favorite_tab.dart';
import 'package:evently/ui/home_view/tab/home_tab/home_tab.dart';
import 'package:evently/ui/home_view/tab/map_tab/map_tab.dart';
import 'package:evently/ui/home_view/tab/profile_tab/profile_tab.dart';
import 'package:evently/ui/home_view/widget/home_nav_item.dart';
import 'package:evently/ui/home_view/widget/home_tabs_view.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  static const List<IconData> _selectedIcons = [
    Icons.home,
    Icons.location_on,
    Icons.favorite,
    Icons.person,
  ];
  static const List<IconData> _unselectedIcons = [
    Icons.home_outlined,
    Icons.location_on_outlined,
    Icons.favorite_border,
    Icons.person_outline,
  ];
  static const List<Widget> _tabs = [
    HomeTab(),
    MapTab(),
    FavoriteTab(),
    ProfileTab(),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    final List<String> labels = [
      text.home,
      text.map,
      text.favorite,
      text.profile,
    ];
    return BlocProvider(
      create: (context) => getIt<FavoritesCubit>()
        // `..` (cascade) creates the cubit and starts listening in one expression.
        ..watchFavorites(context.read<MyUserProvider>().currentUser!.id),
      child: Scaffold(
        extendBody: true,
        body: HomeTabsView(selectedIndex: _selectedIndex, tabs: _tabs),
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          itemCount: _selectedIcons.length,
          activeIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          tabBuilder: (index, isActive) => HomeNavItem(
            icon: isActive ? _selectedIcons[index] : _unselectedIcons[index],
            label: labels[index],
            isSelected: isActive,
          ),
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.softEdge,
          backgroundColor: Theme.of(context).primaryColor,
          notchMargin: 12,
          borderColor: AppColors.whiteColor,
          borderWidth: 3,
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              Navigator.pushNamed(context, AppRoutes.addEventRouteName),
          child: const Icon(Icons.add, color: AppColors.whiteColor, size: 30),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
