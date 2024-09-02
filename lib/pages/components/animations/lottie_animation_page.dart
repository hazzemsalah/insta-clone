import 'package:flutter/material.dart';
import 'package:instaclone/pages/components/animations/models/lottie_animation.dart';
import 'package:lottie/lottie.dart';

class LottieAnimationPage extends StatelessWidget {
  final LottieAnimation animation;
  final bool repeat;
  final bool reverse;

  const LottieAnimationPage({
    super.key,
    required this.animation,
    this.repeat = true,
    this.reverse = false,
  });

  @override
  Widget build(BuildContext context) => Lottie.asset(
        animation.fullPath,
        reverse: reverse,
        repeat: repeat,
      );
}

extension GetFullPath on LottieAnimation {
  String get fullPath => 'assets/animations/$name.json';
}
