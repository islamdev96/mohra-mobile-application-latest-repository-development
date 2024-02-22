import 'dart:math';

import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/multi_tween/multi_tween.dart';
import 'package:simple_animations/stateless_animation/play_animation.dart';

class AnimatedRoute extends PageRouteBuilder {
  final Widget page;

  AnimatedRoute({required this.page, required RouteSettings settings})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) {
            return ListenableProvider(
              create: (context) => animation,
              child: page,
            );
          },
          transitionDuration: const Duration(
            milliseconds: 1100,
          ),
          settings: settings,
        );
}

class SlidingAnimated extends StatelessWidget {
  final double initialOffset;
  final double intervalStart;
  final double intervalEnd;
  final Widget child;
  final Axis direction;
  final double delay;
  // final FadeDirection fadeDirection;
   SlidingAnimated({
    Key? key,
    required this.initialOffset,
    required this.intervalStart,
    required this.intervalEnd,
    required this.child,
    this.direction = Axis.horizontal,
    // this.fadeDirection = FadeDirection.right,
    this.delay = 1,
  }) : super(key: key);
  FadeDirection fadeDirection  =FadeDirection.values[Random().nextInt(3)];
  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<AniProps>()
      ..add(AniProps.opacity, Tween(begin: 0.0, end: 1.0),
          const Duration(milliseconds: 500))
      ..add(AniProps.translateY, Tween(begin: -30.0, end: 0.0),
          const Duration(milliseconds: 500), Curves.easeOut);
    // final animation = Provider.of<Animation<double>>(context, listen: false);
    return PlayAnimation<MultiTweenValues<AniProps>>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, child, value) => Opacity(
        opacity: value.get(AniProps.opacity),
        child: Transform.translate(
            offset: Offset(
              (fadeDirection == FadeDirection.top ||
                  fadeDirection == FadeDirection.bottom)
                  ? 0
                  : value.get(AniProps.translateY) *
                  (fadeDirection == FadeDirection.left ? -1 : 1),
              (fadeDirection == FadeDirection.left ||
                  fadeDirection == FadeDirection.right)
                  ? 0
                  : value.get(AniProps.translateY) *
                  (fadeDirection == FadeDirection.top ? -1 : 1),
            ),
            child: child),
      ),
    );
    // return AnimatedBuilder(
    //   animation: animation,
    //   builder: (context, child) {
    //     return SlideTransition(
    //       position: Tween<Offset>(
    //         begin: beginOffset,
    //         end: Offset.zero,
    //       ).animate(
    //         CurvedAnimation(
    //           curve: Interval(
    //             intervalStart,
    //             intervalEnd,
    //             curve: Curves.ease,
    //           ),
    //           parent: animation,
    //         ),
    //       ),
    //       child: child,
    //     );
    //   },
    //   child: child,
    // );
  }

  Offset get beginOffset => direction == Axis.horizontal
      ? Offset(initialOffset, 0)
      : Offset(0, initialOffset);
}

class FadeAnimated extends StatelessWidget {
  final double intervalStart;
  final double intervalEnd;
  final Widget child;
  final double delay;
  // final FadeDirection? fadeDirection;

   FadeAnimated({
    Key? key,
    required this.intervalStart,
    required this.intervalEnd,
    required this.child,
    // this.fadeDirection ,
    this.delay = 1,
  }) : super(key: key);

  FadeDirection fadeDirection  =FadeDirection.values[Random().nextInt(3)];
  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<AniProps>()
      ..add(AniProps.opacity, Tween(begin: 0.0, end: 1.0),
          const Duration(milliseconds: 500))
      ..add(AniProps.translateY, Tween(begin: -30.0, end: 0.0),
          const Duration(milliseconds: 500), Curves.easeOut);
    // final animation = Provider.of<Animation<double>>(context, listen: false);
    return PlayAnimation<MultiTweenValues<AniProps>>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, child, value) => Opacity(
        opacity: value.get(AniProps.opacity),
        child: Transform.translate(
            offset: Offset(
              (fadeDirection == FadeDirection.top ||
                  fadeDirection == FadeDirection.bottom)
                  ? 0
                  : value.get(AniProps.translateY) *
                  (fadeDirection == FadeDirection.left ? -1 : 1),
              (fadeDirection == FadeDirection.left ||
                  fadeDirection == FadeDirection.right)
                  ? 0
                  : value.get(AniProps.translateY) *
                  (fadeDirection == FadeDirection.top ? -1 : 1),
            ),
            child: child),
      ),
    );
    // return AnimatedBuilder(
    //   animation: animation,
    //   builder: (context, child) {
    //     return FadeTransition(
    //       child: child,
    //       opacity: Tween<double>(
    //         begin: 0,
    //         end: 1,
    //       ).animate(
    //         CurvedAnimation(
    //           curve: Interval(
    //             intervalStart,
    //             intervalEnd,
    //             curve: Curves.bounceInOut,
    //           ),
    //           parent: animation,
    //         ),
    //       ),
    //     );
    //   },
    //   child: child,
    // );
  }
}

CupertinoRoute({required Widget page,required RouteSettings settings}) {
  return CupertinoPageRoute(
      builder: (_) => page, settings: settings);
}

enum FadeDirection { top, bottom, right, left }

enum AniProps { opacity, translateY }