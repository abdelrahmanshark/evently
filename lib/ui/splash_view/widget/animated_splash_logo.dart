import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';

/// Flower logo that blooms in place, then reveals the "Evently" wordmark
/// below it. Driven by a single [progress] animation running from 0 to 1.
class AnimatedSplashLogo extends StatefulWidget {
  const AnimatedSplashLogo({super.key, required this.progress});

  final Animation<double> progress;

  @override
  State<AnimatedSplashLogo> createState() => _AnimatedSplashLogoState();
}

class _AnimatedSplashLogoState extends State<AnimatedSplashLogo> {
  late final CurvedAnimation _bloomCurve;
  late final CurvedAnimation _revealCurve;
  late final CurvedAnimation _wordmarkCurve;

  late final Animation<double> _flowerTurns;
  late final Animation<double> _flowerScale;
  late final Animation<Offset> _wordmarkOffset;

  @override
  void initState() {
    super.initState();
    _bloomCurve = CurvedAnimation(
      parent: widget.progress,
      curve: const Interval(0, 0.55, curve: Curves.easeInOutCubic),
    );
    _revealCurve = CurvedAnimation(
      parent: widget.progress,
      curve: const Interval(0.45, 0.85, curve: Curves.easeOutCubic),
    );
    _wordmarkCurve = CurvedAnimation(
      parent: widget.progress,
      curve: const Interval(0.55, 1, curve: Curves.easeOutCubic),
    );

    // The flower has five-fold symmetry, so a 1/5 turn ends on the same
    // silhouette the native splash showed.
    _flowerTurns = Tween<double>(begin: 0, end: 0.2).animate(_bloomCurve);
    _flowerScale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1, end: 1.12), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.12, end: 1), weight: 1),
    ]).animate(_bloomCurve);
    _wordmarkOffset = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(_wordmarkCurve);
  }

  @override
  void dispose() {
    _bloomCurve.dispose();
    _revealCurve.dispose();
    _wordmarkCurve.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RotationTransition(
          turns: _flowerTurns,
          child: ScaleTransition(
            scale: _flowerScale,
            child: Image.asset(AppAssets.splashLogo, width: 136, height: 141),
          ),
        ),
        // Growing from zero height keeps the flower centered at first (matching
        // the native splash), then lifts it as the wordmark makes room.
        SizeTransition(
          sizeFactor: _revealCurve,
          axisAlignment: -1,
          fixedCrossAxisSizeFactor: 1,
          child: FadeTransition(
            opacity: _wordmarkCurve,
            child: SlideTransition(
              position: _wordmarkOffset,
              child: const Text('Evently', style: AppStyles.primaryMed36),
            ),
          ),
        ),
      ],
    );
  }
}
