import 'package:flutter/material.dart';

import '../../../../core/extension/extensions.dart';
import '../../../../core/resources/assets.gen.dart';
import '../bottom_navigation_scope.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  const BottomNavBar({required this.currentIndex, super.key});

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: context.theme.commonColors.neutralgrey10.withOpacity(.2),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      height: 56 + 20 + bottomPadding,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: context.theme.commonColors.white,
            ),
            padding: EdgeInsets.only(bottom: bottomPadding),
            margin: const EdgeInsets.only(top: 20),
            child: SizedBox(
              height: 64,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _NavBarItem(
                    onTap: (index) => BottomNavigationScope.change(context, index),
                    index: 0,
                    currentIndex: currentIndex,
                    asset: Assets.navBar.home,
                  ),
                  _NavBarItem(
                    onTap: (index) => BottomNavigationScope.change(context, index),
                    index: 1,
                    currentIndex: currentIndex,
                    asset: Assets.navBar.search,
                  ),
                  Opacity(
                    child: Assets.navBar.plus.svg(),
                    opacity: 0,
                  ),
                  _NavBarItem(
                    onTap: (index) => BottomNavigationScope.change(context, index),
                    index: 2,
                    currentIndex: currentIndex,
                    asset: Assets.navBar.favourite,
                  ),
                  _NavBarItem(
                    onTap: (index) => BottomNavigationScope.change(context, index),
                    index: 3,
                    currentIndex: currentIndex,
                    asset: Assets.navBar.profile,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                overlayColor: WidgetStateProperty.all<Color>(context.theme.commonColors.green10),
                borderRadius: BorderRadius.circular(100),
                onTap: () {},
                child: Ink(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: context.theme.commonColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Assets.navBar.plus.svg(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  const _NavBarItem({
    required this.index,
    required this.currentIndex,
    required this.onTap,
    required this.asset,
  });

  final int index;
  final int currentIndex;
  final SvgGenImage asset;
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.commonColors;
    final isSelected = index == currentIndex;
    return InkWell(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: context.theme.durations.pageElements,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          color: isSelected ? colors.green10 : null,
        ),
        padding: const EdgeInsets.all(12),
        child: asset.svg(
          colorFilter: ColorFilter.mode(
            isSelected ? colors.green100 : colors.darkGrey30,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
