import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as cmbs;

import '../extension/extensions.dart';

mixin PrimaryBottomSheet {
  static Future<T?> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    double? elevation,
    double? closeProgressThreshold,
    Clip? clipBehavior,
    bool bounce = true,
    bool expand = false,
    Curve? animationCurve,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
    Duration? duration,
    RouteSettings? settings,
    SystemUiOverlayStyle? overlayStyle,
    EdgeInsets? padding,
    BorderRadiusGeometry? borderRadius,
    Color? backgroundColor,
    ClipRectType clipRectType = ClipRectType.all,
  }) async {
    final modalBottomSheet = cmbs.ModalSheetRoute<T>(
      builder: builder,
      bounce: bounce,
      closeProgressThreshold: closeProgressThreshold,
      containerBuilder: (_, __, child) => _BottomSheet(
        child: child,
        padding: padding,
        clipBehavior: clipBehavior,
        elevation: elevation,
        overlayStyle: overlayStyle,
        borderRadius: borderRadius,
        backgroundColor: backgroundColor,
        clipRectType: clipRectType,
      ),
      expanded: expand,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      animationCurve: animationCurve,
      duration: duration,
      settings: settings,
    );

    final result = await Navigator.of(
      context,
      rootNavigator: useRootNavigator,
    ).push<T>(modalBottomSheet);
    return result;
  }
}

class _BottomSheet extends StatelessWidget {
  final Widget child;
  final Clip? clipBehavior;
  final double? elevation;
  final SystemUiOverlayStyle? overlayStyle;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final ClipRectType clipRectType;

  const _BottomSheet({
    required this.child,
    this.clipRectType = ClipRectType.all,
    this.clipBehavior,
    this.padding,
    this.elevation,
    this.overlayStyle,
    this.borderRadius,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final bottomSheetTheme = Theme.of(context).bottomSheetTheme;
    final colors = context.theme.commonColors;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle ?? SystemUiOverlayStyle.light,
      child: SafeArea(
        child: Padding(
          padding: padding ?? const EdgeInsets.only(top: 60, left: 16, right: 16, bottom: 16),
          child: ClipRRect(
            borderRadius: borderRadius ?? BorderRadius.circular(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ColoredBox(
                  color: backgroundColor ?? colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: const Color.fromRGBO(175, 181, 207, 0.5),
                        ),
                        height: 4,
                        width: 44,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Material(
                    shape: bottomSheetTheme.shape,
                    clipBehavior: clipBehavior ?? bottomSheetTheme.clipBehavior ?? Clip.hardEdge,
                    elevation: elevation ?? bottomSheetTheme.elevation ?? 0,
                    borderRadius: BorderRadius.zero,
                    color: backgroundColor ?? colors.white,
                    child: SizedBox(
                      width: double.infinity,
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: SingleChildScrollView(
                          child: child,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum ClipRectType {
  all,
  top,
}
