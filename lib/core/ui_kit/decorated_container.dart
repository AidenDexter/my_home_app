import 'package:flutter/material.dart';

import '../extension/extensions.dart';

class DecoratedContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  const DecoratedContainer({
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Ink(
          decoration: BoxDecoration(
            color: context.theme.commonColors.white,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(color: context.theme.commonColors.neutralgrey10),
          ),
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      );
}
