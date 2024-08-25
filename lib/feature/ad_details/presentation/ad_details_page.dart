import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/resources/assets.gen.dart';
import '../../../core/ui_kit/decorated_container.dart';
import '../../currency_control/presentation/currency_scope.dart';
import '../../currency_control/presentation/currency_switcher.dart';
import '../../search/domain/entity/search_response.dart';
import 'components/detail_images_carousel.dart';

class AdDetailsPage extends StatelessWidget {
  final SearchItem item;
  const AdDetailsPage({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            DetailImagesCarousel(item),
            _DataLayer(item),
          ],
        ),
      ),
    );
  }
}

class _DataLayer extends StatelessWidget {
  final SearchItem item;
  const _DataLayer(this.item);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Assets.icons.calendar.svg(),
              const SizedBox(width: 8),
              Text(DateFormat('dd MMM. HH:mm').format(item.lastUpdated).toLowerCase()),
              const Spacer(),
              Text('ID: ${item.id}')
            ],
          ),
          const SizedBox(height: 8),
          Text('${item.dynamicTitle}'),
          const SizedBox(height: 8),
          Row(
            children: [
              Assets.icons.location.svg(),
              const SizedBox(width: 8),
              Expanded(child: Text('${item.address}')),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(CurrencyScope.showPrice(context, price: item.price)),
              const SizedBox(width: 8),
              const CurrencySwitcher(),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text('Площадь: ${item.area?.toStringAsFixed(0)} м²'),
              const SizedBox(width: 8),
              const Text('|'),
              const SizedBox(width: 8),
              Text('1 м² - ${CurrencyScope.showPriceSquare(context, price: item.price)}'),
            ],
          ),
          const SizedBox(height: 16),
          const DecoratedContainer(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: Text('Общая площадь')),
                    Expanded(child: Text('Комнаты')),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(child: Text('Спальня')),
                    Expanded(child: Text('Этаж')),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
