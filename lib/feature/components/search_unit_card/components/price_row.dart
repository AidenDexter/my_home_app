import 'package:flutter/material.dart';

import '../../../../core/extension/extensions.dart';
import '../../../currency_control/presentation/currency_scope.dart';
import '../../../currency_control/presentation/currency_switcher.dart';
import '../../../search/domain/entity/search_response.dart';

class PriceRow extends StatelessWidget {
  final Price price;
  const PriceRow(this.price, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: CurrencyScope.showPrice(context, price: price),
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
}
