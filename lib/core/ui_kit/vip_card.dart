import 'package:flutter/material.dart';

import '../resources/assets.gen.dart';

class VipCard extends StatelessWidget {
  final SvgGenImage vipType;
  VipCard.vip({super.key}) : vipType = Assets.icons.vip;
  VipCard.superVip({super.key}) : vipType = Assets.icons.vipSuper;
  VipCard.vipPlus({super.key}) : vipType = Assets.icons.vipPlus;

  @override
  Widget build(BuildContext context) => vipType.svg();
}
