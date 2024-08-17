import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/handler_animation.dart';
import 'package:another_xlider/models/tooltip/tooltip.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:flutter/material.dart';

import '../extension/extensions.dart';

class PrimaryRangeSlider extends StatelessWidget {
  final ValueNotifier<double> startValue;
  final ValueNotifier<double> endValue;
  final double maxValue;
  final double minValue;
  const PrimaryRangeSlider({
    required this.startValue,
    required this.endValue,
    super.key,
    this.maxValue = 33,
    this.minValue = 3,
  });

  @override
  Widget build(BuildContext context) {
    final _handler = FlutterSliderHandler(
      child: CircleAvatar(
        radius: 10,
        backgroundColor: context.theme.commonColors.green100,
        child: Center(
          child: CircleAvatar(
            radius: 5,
            backgroundColor: context.theme.commonColors.white,
          ),
        ),
      ),
    );
    return FlutterSlider(
      values: [startValue.value, endValue.value],
      rangeSlider: true,
      max: maxValue,
      min: minValue,
      trackBar: FlutterSliderTrackBar(
        activeTrackBarHeight: 6,
        inactiveTrackBarHeight: 4,
        activeTrackBar:
            BoxDecoration(color: context.theme.commonColors.green100),
        inactiveTrackBar: BoxDecoration(
          color: context.theme.commonColors.green10,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      handler: _handler,
      rightHandler: _handler,
      handlerHeight: 20,
      handlerWidth: 20,
      tooltip: FlutterSliderTooltip(
        alwaysShowTooltip: false,
        disabled: true,
      ),
      handlerAnimation: const FlutterSliderHandlerAnimation(
        reverseCurve: Curves.bounceIn,
        duration: Duration(milliseconds: 500),
        scale: 1.5,
      ),
      onDragging: (handlerIndex, lowerValue, upperValue) {
        startValue.value = lowerValue as double;
        endValue.value = upperValue as double;
      },
    );
  }
}
