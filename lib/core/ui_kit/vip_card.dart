// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../extension/src/theme_extension.dart';

class VipCard extends StatelessWidget {
  final Color backgroundColor;
  final String cardTitle;

  const VipCard.vip({super.key})
      : cardTitle = 'VIP',
        backgroundColor = const Color(0xFF3B73FC);
  const VipCard.superVip({super.key})
      : cardTitle = 'S-VIP',
        backgroundColor = const Color(0xFFFF3D00);
  const VipCard.vipPlus({super.key})
      : cardTitle = 'VIP+',
        backgroundColor = const Color(0xFFFABD00);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 22,
      width: 36,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            cardTitle,
            style: context.theme.commonTextStyles.body2
                .copyWith(color: context.theme.commonColors.white),
          ),
        ),
      ),
    );
  }
}
