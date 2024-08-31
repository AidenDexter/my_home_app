import 'package:flutter/material.dart';

import '../../../../core/extension/extensions.dart';
import '../../../../core/extension/src/amount.dart';
import '../../../../core/resources/assets.gen.dart';
import '../../../../core/ui_kit/decorated_container.dart';
import '../../../search/domain/entity/search_response.dart';

class DescriptionIconText extends StatelessWidget {
  final SearchItem item;
  const DescriptionIconText({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    final children = [
      if (item.area != null)
        Expanded(
          child: _Item(
            title: 'Общая площадь',
            value: '${item.area?.toStringAsFixed(0).formatNumber()} ${context.l10n.square_meter}',
            icon: Assets.icons.square,
          ),
        ),
      if (item.room != null)
        Expanded(
          child: _Item(
            title: 'Комнаты',
            value: '${item.room}',
            icon: Assets.icons.rooms,
          ),
        ),
      if (item.bedroom != null)
        Expanded(
          child: _Item(
            title: 'Спальни',
            value: '${item.bedroom}',
            icon: Assets.icons.bedrooms,
          ),
        ),
      if (item.floor != null)
        Expanded(
          child: _Item(
            title: 'Этаж',
            value: '${item.floor}${item.totalFloors != null ? ' / ${item.totalFloors}' : ''}',
            icon: Assets.icons.floor,
          ),
        ),
    ];

    final rows = <Widget>[];
    for (var i = 0; i < children.length ~/ 2; i++) {
      if (i != 0) rows.add(const SizedBox(height: 16));
      rows.add(Row(children: [children[0 + i * 2], children[1 + i * 2]]));
    }

    if (children.length % 2 != 0) {
      rows
        ..add(const SizedBox(height: 16))
        ..add(Row(children: [children.last, const Expanded(child: SizedBox.shrink())]));
    }
    return DecoratedContainer(child: Column(children: rows));
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final SvgGenImage icon;

  @override
  Widget build(BuildContext context) {
    final textStyles = context.theme.commonTextStyles;
    final colors = context.theme.commonColors;
    return Row(
      children: [
        icon.svg(height: 20),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textStyles.body2.copyWith(color: colors.darkGrey70),
              ),
              Text(value, style: textStyles.body1),
            ],
          ),
        ),
      ],
    );
  }
}
