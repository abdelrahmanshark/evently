import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/ob_page.dart';
import 'package:evently/ui/on_boarding/intro_view/widget/intro_navigation_row.dart';
import 'package:evently/ui/on_boarding/intro_view/widget/intro_page_content.dart';
import 'package:evently/utils/app_animations.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_images.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/shared_preferences.dart';
import 'package:flutter/material.dart';

class IntroView extends StatefulWidget {
  const IntroView({super.key});

  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// Goes to the previous intro page.
  void _goBack() {
    _pageController.previousPage(
      duration: AppAnimations.pageJump,
      curve: AppAnimations.pageJumpCurve,
    );
  }

  /// Goes to the next intro page, or finishes the intro on the last one.
  Future<void> _goNext(int pageCount) async {
    if (_currentIndex < pageCount - 1) {
      _pageController.nextPage(
        duration: AppAnimations.pageJump,
        curve: AppAnimations.pageJumpCurve,
      );
      return;
    }
    await saveIntroCompleted();
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.loginRouteName,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppImages images = Theme.of(context).extension<AppImages>()!;
    final AppLocalizations text = AppLocalizations.of(context)!;
    final List<ObPage> pages = [
      ObPage(
        title: text.ob1_title,
        body: text.ob1_body,
        image: AppAssets.ob1LightImage,
      ),
      ObPage(title: text.ob2_title, body: text.ob2_body, image: images.oB2),
      ObPage(title: text.ob3_title, body: text.ob3_body, image: images.oB3),
    ];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(AppAssets.eventlyHeader),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: pages.length,
                  onPageChanged: (index) =>
                      setState(() => _currentIndex = index),
                  itemBuilder: (context, index) =>
                      IntroPageContent(page: pages[index]),
                ),
              ),
              IntroNavigationRow(
                currentIndex: _currentIndex,
                pageCount: pages.length,
                onBack: _goBack,
                onNext: () => _goNext(pages.length),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
