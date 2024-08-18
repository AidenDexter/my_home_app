import 'package:flutter/material.dart';

import '../extension/extensions.dart';

@immutable
class PrimaryElevatedButton extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? progressIndicatorColor;
  final Widget? icon;
  final bool isSecondary;

  const PrimaryElevatedButton({
    required this.child,
    this.onPressed,
    this.isLoading = false,
    this.foregroundColor,
    this.backgroundColor,
    this.progressIndicatorColor,
    super.key,
  })  : icon = null,
        isSecondary = false;

  const PrimaryElevatedButton.icon({
    required this.child,
    required this.icon,
    this.onPressed,
    this.isLoading = false,
    this.foregroundColor,
    this.progressIndicatorColor,
    this.backgroundColor,
    super.key,
  }) : isSecondary = false;

  const PrimaryElevatedButton.secondary({
    required this.child,
    this.onPressed,
    this.isLoading = false,
    this.foregroundColor,
    this.progressIndicatorColor,
    this.backgroundColor,
    this.icon,
    super.key,
  }) : isSecondary = true;

  @override
  Widget build(BuildContext context) {
    final style = ElevatedButton.styleFrom(
      foregroundColor: foregroundColor ?? (isSecondary ? context.theme.commonColors.darkGrey70 : null),
      backgroundColor: backgroundColor ?? (isSecondary ? context.theme.commonColors.neutralgrey5 : null),
      elevation: isSecondary ? 0 : null,
    );

    if (icon != null) {
      return ElevatedButton.icon(
        style: style,
        onPressed: isLoading ? null : onPressed,
        icon: icon,
        label: isLoading
            ? _ProgressIndicator(
                color: progressIndicatorColor,
              )
            : child,
      );
    }
    return ElevatedButton(
      style: style,
      onPressed: isLoading ? null : onPressed,
      child: isLoading ? _ProgressIndicator(color: progressIndicatorColor) : child,
    );
  }
}

@immutable
class _ProgressIndicator extends StatelessWidget {
  final Color? color;

  const _ProgressIndicator({this.color});

  @override
  Widget build(BuildContext context) => SizedBox.square(
        dimension: 20,
        child: CircularProgressIndicator(
          color: color ?? context.theme.commonColors.white,
          strokeWidth: 3,
        ),
      );
}
