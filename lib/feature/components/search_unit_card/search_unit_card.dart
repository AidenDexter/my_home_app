import 'package:flutter/material.dart';

import '../../../core/extension/extensions.dart';
import '../../../core/resources/assets.gen.dart';
import '../../../core/ui_kit/currency_switcher.dart';
import '../../search/domain/entity/search_response.dart';

class SearchUnitCard extends StatelessWidget {
  final SearchItem item;

  const SearchUnitCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.commonColors;
    final textStyles = context.theme.commonTextStyles;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ImagesCarousel(item),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.dynamicTitle ?? 'null',
                      style: textStyles.title3,
                    ),
                    const SizedBox(height: 12),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '${item.price.first.priceTotal} ₾',
                            style: textStyles.title3,
                          ),
                          WidgetSpan(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: CurrencySwitcher(onChange: (_) {}),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                            TextSpan(
                              text: item.floor!.toString(),
                            ),
                          ],
                          if (item.room != null) ...[
                            WidgetSpan(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8, left: 16),
                                child: Assets.icons.rooms.svg(),
                              ),
                              alignment: PlaceholderAlignment.middle,
                            ),
                            TextSpan(
                              text: item.room.toString(),
                            ),
                          ],
                          if (item.bedroom != null) ...[
                            WidgetSpan(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8, left: 16),
                                child: Assets.icons.bedrooms.svg(),
                              ),
                              alignment: PlaceholderAlignment.middle,
                            ),
                            TextSpan(
                              text: item.bedroom.toString(),
                            ),
                          ],
                          if (item.area != null) ...[
                            WidgetSpan(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8, left: 16),
                                child: Assets.icons.square.svg(),
                              ),
                              alignment: PlaceholderAlignment.middle,
                            ),
                            TextSpan(
                              text: item.area?.toString() ?? '',
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(item.address ?? ''),
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
                      child: Text(item.cityName ?? ''),
                    ),
                    Text(item.lastUpdated.toString()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImagesCarousel extends StatefulWidget {
  const _ImagesCarousel(this.item);

  final SearchItem item;

  @override
  State<_ImagesCarousel> createState() => _ImagesCarouselState();
}

class _ImagesCarouselState extends State<_ImagesCarousel> {
  late final PageController _carouselController;

  @override
  void initState() {
    _carouselController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.item.images.isEmpty) return const SizedBox();
    return SizedBox(
      height: 214,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: PageView.builder(
              controller: _carouselController,
              itemBuilder: (context, index) => Image.network(
                widget.item.images[index].thumb,
                fit: BoxFit.cover,
              ),
              itemCount: widget.item.images.length,
            ),
          ),
          if (widget.item.isSuperVip)
            Positioned(
              top: 12,
              left: 12,
              child: Assets.icons.vipSuper.svg(height: 24),
            )
          else if (widget.item.isVipPlus)
            Positioned(
              top: 12,
              left: 12,
              child: Assets.icons.vipPlus.svg(height: 24),
            )
          else if (widget.item.isVip)
            Positioned(
              top: 12,
              left: 12,
              child: Assets.icons.vip.svg(height: 24),
            ),
          Positioned(
            top: 12,
            right: 12,
            child: Assets.icons.like.svg(height: 24),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () => _carouselController.nextPage(
                    duration: context.theme.durations.pageElements,
                    curve: Curves.easeInOut,
                  ),
                  child: Ink(
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, color: context.theme.commonColors.black.withOpacity(0.5)),
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      Icons.keyboard_arrow_right_rounded,
                      color: context.theme.commonColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () => _carouselController.previousPage(
                    duration: context.theme.durations.pageElements,
                    curve: Curves.easeInOut,
                  ),
                  child: Ink(
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, color: context.theme.commonColors.black.withOpacity(0.5)),
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      Icons.keyboard_arrow_left_rounded,
                      color: context.theme.commonColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
