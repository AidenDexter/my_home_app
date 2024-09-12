import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'primary_icon_button.dart';

@immutable
class PrimaryAppBar extends StatefulWidget implements PreferredSizeWidget {
  /// Title of the app bar.
  final Widget? title;

  /// Widget to display on the left side of the app bar.
  final Widget? leading;

  /// Widget to display on the right side of the app bar.
  final Widget? action;

  final Color? backgroundColor;
  final bool ignoreChildRoutes;
  final bool ignoreLeading;
  final Function()? onBackPressed;

  @override
  Size get preferredSize => const Size.fromHeight(50);

  /// Creates a primary app bar.
  const PrimaryAppBar({
    this.title,
    this.action,
    this.leading,
    this.backgroundColor,
    this.ignoreChildRoutes = true,
    this.ignoreLeading = false,
    this.onBackPressed,
    super.key,
  });

  @override
  State<PrimaryAppBar> createState() => _PrimaryAppBarState();
}

class _PrimaryAppBarState extends State<PrimaryAppBar> {
  @override
  Widget build(BuildContext context) {
    var leading = widget.leading ?? const SizedBox(width: 12);
    var leadingWidth = widget.leading == null ? 12.0 : 48.0;
    if (widget.leading == null && context.canPop() && !widget.ignoreLeading) {
      leadingWidth = 48;
      leading = _Leading(onPressed: widget.onBackPressed ?? context.pop);
    }

    // Action
    List<Widget>? actions;
    var action = widget.action;
    if (action != null) {
      action = _TrailingWrap(child: action);
      actions = [action];
    } else {
      actions = [const SizedBox(width: 16)];
    }

    return AppBar(
      backgroundColor: widget.backgroundColor,
      leadingWidth: leadingWidth,
      leading: leading,
      title: widget.title,
      actions: actions,
      titleSpacing: 4,
      centerTitle: true,
    );
  }
}

@immutable
class _Leading extends StatelessWidget {
  final VoidCallback onPressed;

  const _Leading({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.zero;
    const child = Icon(Icons.keyboard_arrow_left_rounded);

    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        top: 5,
        bottom: 5,
      ),
      child: PrimaryIconButton(
        icon: child,
        padding: padding,
        constraints: BoxConstraints.tight(const Size(40, 40)),
        onTap: onPressed,
      ),
    );
  }
}

@immutable
class _TrailingWrap extends StatelessWidget {
  final Widget child;

  const _TrailingWrap({required this.child});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          top: 5,
          right: 8,
          bottom: 5,
        ),
        child: child,
      );
}
