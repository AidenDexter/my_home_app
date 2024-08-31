import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:styled_text/styled_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/extension/extensions.dart';
import '../../../core/extension/src/theme_extension.dart';
import '../../../core/resources/assets.gen.dart';
import '../../../core/ui_kit/circle_button.dart';
import '../../../core/ui_kit/decorated_container.dart';
import '../../../core/ui_kit/primary_elevated_button.dart';
import '../../currency_control/presentation/currency_scope.dart';
import '../../currency_control/presentation/currency_switcher.dart';
import '../../localization_control/presentation/localization_scope.dart';
import '../../search/domain/entity/search_response.dart';
import 'components/description_icon_text.dart';
import 'components/detail_images_carousel.dart';

class AdDetailsPage extends StatelessWidget {
  final SearchItem item;
  const AdDetailsPage({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            expandedHeight: 340,
            actions: const [SizedBox.shrink()],
            flexibleSpace: ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
              child: FlexibleSpaceBar(
                expandedTitleScale: 1,
                titlePadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                centerTitle: true,
                title: Row(
                  children: [
                    CircleButton(
                      icon: const Icon(Icons.keyboard_arrow_left_rounded, size: 24),
                      onTap: context.pop,
                    ),
                    const Spacer(),
                    CircleButton(
                      icon: const Opacity(opacity: .2, child: Icon(Icons.favorite_border, size: 22)),
                      onTap: () {},
                    ),
                    const SizedBox(width: 8),
                    CircleButton(
                      icon: Assets.icons.share.svg(height: 20),
                      onTap: _onShareTap,
                    ),
                  ],
                ),
                background: DetailImagesCarousel(item),
              ),
            ),
          ),
          SliverToBoxAdapter(child: _DataLayer(item)),
        ],
      ),
    );
  }

  void _onShareTap() => Share.share('https://www.myhome.ge/pr/${item.id}');
}

class _DataLayer extends StatelessWidget {
  final SearchItem item;
  const _DataLayer(this.item);

  @override
  Widget build(BuildContext context) {
    final textStyles = context.theme.commonTextStyles;
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
                Text(DateFormat('dd MMM. HH:mm', LocalizationScope.getLocaleCode(context))
                    .format(item.lastUpdated)
                    .replaceAll('..', '.')
                    .toLowerCase()),
                const Spacer(),
                SelectableText('ID: ${item.id}')
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
                  Text('Площадь: ${item.area?.toStringAsFixed(0)} ${context.l10n.square_meter}'),
                  const SizedBox(width: 8),
                  const Text('|'),
                  const SizedBox(width: 8),
                ],
                Text('1 ${context.l10n.square_meter} - ${CurrencyScope.showPriceSquare(context, price: item.price)}'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          DescriptionIconText(item: item),
          const SizedBox(height: 16),
          if (item.userTitle != null) ...[
            DecoratedContainer(
              child: Column(
                children: [
                  Row(
                    children: [
                      Assets.icons.man.svg(),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.userTitle!,
                              style: textStyles.label,
                            ),
                            if (item.userType != null) ...[
                              const SizedBox(height: 6),
                              if (item.userType!.type == 'physical')
                                Container(
                                  decoration: BoxDecoration(
                                    color: context.theme.commonColors.neutralgrey5,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  child: Text(
                                    'Собственник',
                                    style: textStyles.body2.copyWith(
                                      color: context.theme.commonColors.darkGrey70,
                                    ),
                                  ),
                                )
                              else
                                Container(
                                  decoration: BoxDecoration(
                                    color: context.theme.commonColors.green10,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  child: Text(
                                    'Агент',
                                    style: textStyles.body2.copyWith(
                                      color: context.theme.commonColors.green100,
                                    ),
                                  ),
                                ),
                            ]
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  PrimaryElevatedButton.secondary(
                    onPressed: () => launchUrl(Uri.parse('https://www.myhome.ge/pr/${item.id}')),
                    icon: const Icon(Icons.open_in_browser),
                    child: const Text('Открыть в браузере'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
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
                  StyledText(
                    text: item.comment!,
                    style: textStyles.body,
                  ),
                ],
              ),
            ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
