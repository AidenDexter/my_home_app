// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../extension/extensions.dart';

class Skeleton extends StatelessWidget {
  final double? radius;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;

  const Skeleton.circle({required this.radius, this.backgroundColor, super.key})
      : width = null,
        height = null,
        borderRadius = null;

  const Skeleton.rect(
      {required this.width, required this.height, required this.borderRadius, this.backgroundColor, super.key})
      : radius = null;

  @override
  Widget build(BuildContext context) {
    if (radius != null) {
      return _CircleSkeleton(
        radius!,
        backgroundColor: backgroundColor,
      );
    }

    return _RectangleSkeleton(
      width: width!,
      height: height!,
      borderRadius: borderRadius!,
      backgroundColor: backgroundColor,
    );
  }
}

class _CircleSkeleton extends StatelessWidget {
  final double radius;
  final Color? backgroundColor;
  const _CircleSkeleton(this.radius, {this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _ShimmerAnimation(
      child: DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              offset: const Offset(0, 4),
              color: context.theme.commonColors.black.withOpacity(0.03),
            )
          ],
          color: backgroundColor ?? theme.cardColor,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: SizedBox.square(dimension: radius * 2),
      ),
    );
  }
}

class _RectangleSkeleton extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius borderRadius;
  final Color? backgroundColor;
  const _RectangleSkeleton({
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _ShimmerAnimation(
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: context.theme.commonColors.neutralgrey5),
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              offset: const Offset(0, 4),
              color: context.theme.commonColors.black.withOpacity(0.03),
            )
          ],
          color: backgroundColor ?? theme.cardColor,
          borderRadius: borderRadius,
        ),
        child: SizedBox(width: width, height: height),
      ),
    );
  }
}

class _ShimmerAnimation extends StatelessWidget {
  final Widget child;
  const _ShimmerAnimation({required this.child});

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        ShimmerEffect(
          color: context.theme.commonColors.neutralgrey10.withOpacity(.5),
          duration: const Duration(milliseconds: 1200),
        ),
      ],
      onComplete: (controller) => controller.repeat(),
      child: child,
    );
  }
}
