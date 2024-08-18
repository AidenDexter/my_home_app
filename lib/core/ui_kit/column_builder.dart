import 'dart:math' as math show max;

import 'package:flutter/widgets.dart';

/// Аналог ListView.builder
/// В данном случае используется в Column
@immutable
class ColumnBuilder extends StatelessWidget {
  final IndexedWidgetBuilder itemBuilder;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final VerticalDirection verticalDirection;
  final int itemCount;
  final IndexedWidgetBuilder? separatorBuilder;

  const ColumnBuilder({
    required this.itemBuilder,
    required this.itemCount,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.verticalDirection = VerticalDirection.down,
    super.key,
  }) : separatorBuilder = null;

  const ColumnBuilder.separator({
    required this.itemBuilder,
    required this.itemCount,
    required this.separatorBuilder,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.verticalDirection = VerticalDirection.down,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: mainAxisSize,
        mainAxisAlignment: mainAxisAlignment,
        verticalDirection: verticalDirection,
        children: List<Widget>.generate(
          separatorBuilder != null ? _computeActualChildCount(itemCount) : itemCount,
          (index) {
            if (separatorBuilder == null) {
              return itemBuilder(context, index);
            }
            final itemIndex = index ~/ 2;
            final widget = index.isEven ? itemBuilder(context, itemIndex) : separatorBuilder!(context, itemIndex);
            return widget;
          },
        ).toList(),
      );
}

// Helper method to compute the actual child count for the
// separated constructor.
int _computeActualChildCount(int itemCount) => math.max(0, itemCount * 2 - 1);
