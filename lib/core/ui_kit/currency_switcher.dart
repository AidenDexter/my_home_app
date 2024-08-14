// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flutter/material.dart';

import '../extension/src/theme_extension.dart';
import '../resources/assets.gen.dart';

class CurrencySwitcher extends StatefulWidget {
  final Function(bool _isLariEnabled) onChange;
  const CurrencySwitcher({required this.onChange, super.key});

  @override
  State<CurrencySwitcher> createState() => _CurrencySwitcherState();
}

class _CurrencySwitcherState extends State<CurrencySwitcher> {
  bool _isLariEnabled = true;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.commonColors;
    return GestureDetector(
      onTap: () {
        setState(() => _isLariEnabled = !_isLariEnabled);
        widget.onChange(_isLariEnabled);
      },
      child: SizedBox(
        width: 40,
        height: 20,
        child: Stack(
          fit: StackFit.expand,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: colors.white,
                border: Border.all(
                  color: colors.neutralgrey10,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            AnimatedAlign(
              alignment:
                  _isLariEnabled ? Alignment.centerRight : Alignment.centerLeft,
              duration: const Duration(milliseconds: 200),
              child: SizedBox.square(
                dimension: 20,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: colors.green100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                SizedBox.square(
                  dimension: 20,
                  child: Assets.icons.lari.svg(
                    fit: BoxFit.none,
                    colorFilter: _fetchFilter(isEnable: _isLariEnabled),
                  ),
                ),
                SizedBox.square(
                  dimension: 20,
                  child: Assets.icons.dollar.svg(
                    fit: BoxFit.none,
                    colorFilter: _fetchFilter(isEnable: !_isLariEnabled),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ColorFilter _fetchFilter({required bool isEnable}) => ColorFilter.mode(
      isEnable
          ? context.theme.commonColors.black
          : context.theme.commonColors.white,
      BlendMode.srcIn);
}
