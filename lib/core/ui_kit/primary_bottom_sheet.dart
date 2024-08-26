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
    SystemUiOverlayStyle overlayStyle = SystemUiOverlayStyle.light,
    EdgeInsets padding = const EdgeInsets.only(top: 60, left: 16, right: 16, bottom: 16),
    BorderRadiusGeometry borderRadius = const BorderRadius.all(Radius.circular(24)),
    Color? backgroundColor,
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
  final SystemUiOverlayStyle overlayStyle;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadius;
  final Color? backgroundColor;

  const _BottomSheet({
    required this.child,
    required this.borderRadius,
    required this.padding,
    required this.overlayStyle,
    this.clipBehavior,
    this.elevation,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final bottomSheetTheme = Theme.of(context).bottomSheetTheme;
    final colors = context.theme.commonColors;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: SafeArea(
        child: Padding(
          padding: padding,
          child: Material(
            shape: bottomSheetTheme.shape,
            clipBehavior: clipBehavior ?? bottomSheetTheme.clipBehavior ?? Clip.hardEdge,
            elevation: elevation ?? bottomSheetTheme.elevation ?? 0,
            borderRadius: borderRadius,
            color: backgroundColor ?? colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: colors.darkGrey30,
                      ),
                      height: 4,
                      width: 44,
                    ),
                  ),
                ),
                Flexible(
                  child: SizedBox(
                    width: double.infinity,
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      removeBottom: true,
                      child: ListView(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        children: [child],
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
