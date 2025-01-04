import 'package:flutter/material.dart';

import '../extension/extensions.dart';

class DecoratedContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final BorderRadius borderRadius;
  const DecoratedContainer({
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.onTap,
    this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: Ink(
          decoration: BoxDecoration(
            color: backgroundColor ?? context.theme.commonColors.white,
            borderRadius: borderRadius,
            border: Border.all(color: context.theme.commonColors.neutralgrey10),
          ),
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      );
}
