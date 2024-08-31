import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/extension/extensions.dart';
import '../../../core/resources/assets.gen.dart';
import '../../../core/router/routes_enum.dart';
import '../../localization_control/presentation/localization_scope.dart';
import '../../search/domain/entity/search_response.dart';
import 'components/images_carousel.dart';
import 'components/price_row.dart';

class SearchUnitCard extends StatelessWidget {
  final SearchItem item;
  final int? maxTextLines;

  const SearchUnitCard(this.item, {this.maxTextLines, super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.commonColors;
    final textStyles = context.theme.commonTextStyles;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.push(AdDetailsRoutes.details.path, extra: item),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colors.neutralgrey10),
          ),
          child: DefaultTextStyle(
            style: textStyles.body1.copyWith(
              color: colors.darkGrey70,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImagesCarousel(item),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.dynamicTitle ?? 'null',
                        style: textStyles.title3,
                        maxLines: maxTextLines,
                        overflow: maxTextLines != null ? TextOverflow.ellipsis : null,
                      ),
                      const SizedBox(height: 12),
                      PriceRow(item.price),
                      const SizedBox(height: 12),
                      Text.rich(
                        TextSpan(
                          children: [
                            if (item.floor != null) ...[
                              WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Assets.icons.floor.svg(),
                                ),
                                alignment: PlaceholderAlignment.middle,
                              ),
                              TextSpan(text: item.floor!.toString()),
                              const WidgetSpan(child: SizedBox(width: 16)),
                            ],
                            if (item.room != null) ...[
                              WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Assets.icons.rooms.svg(),
                                ),
                                alignment: PlaceholderAlignment.middle,
                              ),
                              TextSpan(text: item.room.toString()),
                              const WidgetSpan(child: SizedBox(width: 16)),
                            ],
                            if (item.bedroom != null) ...[
                              WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Assets.icons.bedrooms.svg(),
                                ),
                                alignment: PlaceholderAlignment.middle,
                              ),
                              TextSpan(text: item.bedroom.toString()),
                              const WidgetSpan(child: SizedBox(width: 16)),
                            ],
                            if (item.area != null) ...[
                              WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Assets.icons.square.svg(),
                                ),
                                alignment: PlaceholderAlignment.middle,
                              ),
                              TextSpan(text: '${item.area!.toStringAsFixed(0)} ${context.l10n.square_meter}'),
                              const WidgetSpan(child: SizedBox(width: 16)),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        item.address ?? '',
                        maxLines: maxTextLines,
                        overflow: maxTextLines != null ? TextOverflow.ellipsis : null,
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  thickness: 0.5,
                  color: colors.neutralgrey10,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.cityName ?? '',
                          maxLines: maxTextLines,
                          overflow: maxTextLines != null ? TextOverflow.ellipsis : null,
                        ),
                      ),
                      Text(DateFormat('dd MMM. HH:mm', LocalizationScope.getLocaleCode(context))
                          .format(item.lastUpdated)
                          .replaceAll('..', '.')
                          .toLowerCase()),
                    ],
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
