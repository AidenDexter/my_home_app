import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../../../core/extension/src/theme_extension.dart';
import '../../../core/resources/assets.gen.dart';
import '../../../core/ui_kit/decorated_container.dart';
import '../../currency_control/presentation/currency_scope.dart';
import '../../currency_control/presentation/currency_switcher.dart';
import '../../search/domain/entity/search_response.dart';
import 'components/description_icon_text.dart';
import 'components/detail_images_carousel.dart';

class AdDetailsPage extends StatelessWidget {
  final SearchItem item;
  const AdDetailsPage({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          DetailImagesCarousel(item),
          _DataLayer(item),
        ],
      ),
    );
  }
}

class _DataLayer extends StatelessWidget {
  final SearchItem item;
  const _DataLayer(this.item);

  @override
  Widget build(BuildContext context) {
    final textStyles = context.theme.commonTextStyles;
    final colors = context.theme.commonColors;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultTextStyle(
            style: textStyles.body1,
            child: Row(
              children: [
                Assets.icons.calendar.svg(),
                const SizedBox(width: 8),
                Text(DateFormat('dd MMM. HH:mm').format(item.lastUpdated).toLowerCase()),
                const Spacer(),
                Text('ID: ${item.id}')
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${item.dynamicTitle}',
            style: textStyles.headline2,
          ),
          const SizedBox(height: 8),
          if (item.address != null) ...[
            InkWell(
              borderRadius: BorderRadius.circular(4),
              onTap: () {
                if (item.lat != null && item.lng != null) {
                  MapsLauncher.launchCoordinates(item.lat!, item.lng!);
                } else {
                  MapsLauncher.launchQuery(item.address!);
                }
              },
              child: Row(
                children: [
                  Assets.icons.location.svg(),
                  const SizedBox(width: 8),
                  Expanded(child: Text('${item.address}', style: textStyles.body1)),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
          Row(
            children: [
              Text(
                CurrencyScope.showPrice(context, price: item.price),
                style: textStyles.headline1,
              ),
              const SizedBox(width: 16),
              const CurrencySwitcher(),
            ],
          ),
          const SizedBox(height: 16),
          DefaultTextStyle(
            style: textStyles.label,
            child: Row(
              children: [
                if (item.area != null) ...[
                  Text('Площадь: ${item.area?.toStringAsFixed(0)} м²'),
                  const SizedBox(width: 8),
                  const Text('|'),
                  const SizedBox(width: 8),
                ],
                Text('1 м² - ${CurrencyScope.showPriceSquare(context, price: item.price)}'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          DescriptionIconText(item: item),
          const SizedBox(height: 16),
          if (item.comment != null)
            DecoratedContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Краткое описание',
                    style: textStyles.headline3,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    item.comment!,
                    style: textStyles.body,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
