import 'package:flutter/material.dart';

import '../extension/extensions.dart';

class DecoratedContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  const DecoratedContainer({
    required this.child,
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.theme.commonColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.theme.commonColors.neutralgrey10),
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}
