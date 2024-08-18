import 'package:flutter/material.dart';

@immutable
class PrimaryIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onTap;
  final String? tooltip;
  final BoxConstraints? constraints;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  const PrimaryIconButton({
    required this.icon,
    this.tooltip,
    this.onTap,
    this.constraints,
    this.padding,
    super.key,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) => IconButton(
        icon: icon,
        style: IconButton.styleFrom(
          backgroundColor: backgroundColor,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        padding: padding ?? EdgeInsets.zero,
        constraints: constraints ?? BoxConstraints.tight(const Size.square(32)),
        tooltip: tooltip,
        onPressed: onTap,
      );
}
