import 'package:evently/ui/splash_view/widget/animated_splash_logo.dart';
import 'package:evently/utils/app_animations.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key, required this.nextRouteName});

  /// Screen opened once the splash animation finishes.
  final String nextRouteName;

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: AppAnimations.splash,
  );
  bool _hasStarted = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_hasStarted) return;
    _hasStarted = true;
    _playThenLeave();
  }

  /// Swaps the native splash for the animated one, then opens the next screen.
  Future<void> _playThenLeave() async {
    await precacheImage(const AssetImage(AppAssets.splashLogo), context);
    FlutterNativeSplash.remove();
    await _controller.forward();
    await Future<void>.delayed(AppAnimations.splashHold);
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, widget.nextRouteName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: AnimatedSplashLogo(progress: _controller)),
    );
  }
}
