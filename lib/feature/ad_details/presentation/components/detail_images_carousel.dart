import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/extension/extensions.dart';
import '../../../../core/resources/assets.gen.dart';
import '../../../../core/ui_kit/circle_button.dart';
import '../../../search/domain/entity/search_response.dart';

class DetailImagesCarousel extends StatefulWidget {
  const DetailImagesCarousel(this.item, {super.key});
  final SearchItem item;

  @override
  State<DetailImagesCarousel> createState() => _DetailImagesCarouselState();
}

class _DetailImagesCarouselState extends State<DetailImagesCarousel> {
  List<Images> get images => widget.item.images;
  late final PageController _carouselController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _carouselController = PageController()..addListener(_onChangePage);
  }

  void _onChangePage() {
    if (mounted) {
      setState(() {
        _currentPage = _carouselController.page?.round() ?? 0;
      });
    }
  }

  @override
  void dispose() {
    _carouselController
      ..removeListener(_onChangePage)
      ..dispose();
    super.dispose();
  }

  void _onShareTap() => Share.share('https://www.myhome.ge/pr/19063268');

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) return const SizedBox();
    final topPadding = MediaQuery.of(context).padding.top;

    return SizedBox(
      height: 340 + topPadding,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: PageView.builder(
              allowImplicitScrolling: true,
              controller: _carouselController,
              itemBuilder: (context, index) => Positioned.fill(
                child: CachedNetworkImage(
                  imageUrl: images[index].thumb,
                  fit: BoxFit.cover,
                ),
              ),
              itemCount: images.length,
            ),
          ),
          Positioned(
            top: 16 + topPadding,
            left: 16,
            right: 16,
            child: Row(
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
          ),
          Positioned(
            bottom: 12,
            left: 16,
            child: VipLabel(widget.item),
          ),
          Positioned(
            bottom: 12,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: context.theme.commonColors.black.withOpacity(0.5),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              child: Text(
                '${_currentPage + 1} / ${widget.item.images.length}',
                style: context.theme.commonTextStyles.label.copyWith(
                  color: context.theme.commonColors.white,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VipLabel extends StatelessWidget {
  final SearchItem item;
  const VipLabel(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    if (item.isSuperVip) return Assets.icons.vipSuper.svg(height: 24);

    if (item.isVipPlus) return Assets.icons.vipPlus.svg(height: 24);

    if (item.isVip) return Assets.icons.vip.svg(height: 24);

    return const SizedBox.shrink();
  }
}
