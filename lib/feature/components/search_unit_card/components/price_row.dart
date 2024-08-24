import 'package:flutter/material.dart';

import '../../../../core/extension/extensions.dart';
import '../../../currency_control/domain/entity/currency.dart';
import '../../../currency_control/presentation/currency_scope.dart';
import '../../../currency_control/presentation/currency_switcher.dart';
import '../../../search/domain/entity/search_response.dart';

class PriceRow extends StatelessWidget {
  final Price price;
  const PriceRow(this.price, {super.key});

  @override
  Widget build(BuildContext context) {
    final isLariEnabled = CurrencyScope.currency(context) == Currency.lari;
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text:
                '${formatNumber((isLariEnabled ? price.first : price.second).priceTotal.toString())} ${isLariEnabled ? '₾' : r'$'}',
            style: context.theme.commonTextStyles.title3,
          ),
          const WidgetSpan(
            child: Padding(
              padding: EdgeInsets.only(left: 16),
              child: CurrencySwitcher(),
            ),
          ),
        ],
      ),
    );
  }

  String formatNumber(String number) {
    final formatted = StringBuffer();
    var count = 0;

    for (var i = number.length - 1; i >= 0; i--) {
      if (count > 0 && count % 3 == 0) {
        formatted.write(' ');
      }
      formatted.write(number[i]);
      count++;
    }

    return formatted.toString().split('').reversed.join();
  }
}
