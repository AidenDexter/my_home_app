// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flutter/material.dart';

import '../../../core/extension/src/theme_extension.dart';
import '../../../core/resources/assets.gen.dart';
import '../domain/entity/currency.dart';
import 'currency_scope.dart';

class CurrencySwitcher extends StatelessWidget {
  const CurrencySwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final currency = CurrencyScope.currency(context);
    final isLariEnabled = currency == Currency.lari;
    final colors = context.theme.commonColors;
    return GestureDetector(
      onTap: () => CurrencyScope.change(context, currency: isLariEnabled ? Currency.dollar : Currency.lari),
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
              alignment: isLariEnabled ? Alignment.centerLeft : Alignment.centerRight,
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
                    colorFilter: _fetchFilter(context, isEnable: isLariEnabled),
                  ),
                ),
                SizedBox.square(
                  dimension: 20,
                  child: Assets.icons.dollar.svg(
                    fit: BoxFit.none,
                    colorFilter: _fetchFilter(context, isEnable: !isLariEnabled),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ColorFilter _fetchFilter(BuildContext context, {required bool isEnable}) =>
      ColorFilter.mode(isEnable ? context.theme.commonColors.white : context.theme.commonColors.black, BlendMode.srcIn);
}
