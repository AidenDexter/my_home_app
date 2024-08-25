import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/extension/extensions.dart';
import '../../../../core/resources/assets.gen.dart';
import '../../../search/domain/entity/search_response.dart';
import 'slide_button.dart';

class ImagesCarousel extends StatefulWidget {
  const ImagesCarousel(this.item, {super.key});
  final SearchItem item;

  @override
  State<ImagesCarousel> createState() => _ImagesCarouselState();
}

class _ImagesCarouselState extends State<ImagesCarousel> {
  List<Images> get images => widget.item.images;
  late final PageController _carouselController;
  int _currentPage = 0;
  bool _isLastPage = false;
  bool _isFirstPage = true;

  @override
  void initState() {
    super.initState();
    _carouselController = PageController()..addListener(_onChangePage);
  }

  void _onChangePage() {
    if (mounted) {
      setState(() {
        _currentPage = _carouselController.page?.toInt() ?? 0;
        _isLastPage = _currentPage == images.length - 1;
        _isFirstPage = _currentPage == 0;
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

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) return const SizedBox();

    return SizedBox(
      height: 214,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: PageView.builder(
              allowImplicitScrolling: true,
              controller: _carouselController,
              itemBuilder: (context, index) => CachedNetworkImage(
                imageUrl: images[index].thumb,
                fit: BoxFit.cover,
              ),
              itemCount: images.length,
            ),
          ),
          Positioned(
            top: 12,
            left: 12,
            child: VipLabel(widget.item),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: Assets.icons.like.svg(height: 24),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SlideButton(
              onTap: () => _carouselController.nextPage(
                duration: context.theme.durations.pageElements,
                curve: Curves.easeInOut,
              ),
              isNotVisible: _isLastPage,
              icon: Icons.keyboard_arrow_right_rounded,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: SlideButton(
              onTap: () => _carouselController.previousPage(
                duration: context.theme.durations.pageElements,
                curve: Curves.easeInOut,
              ),
              isNotVisible: _isFirstPage,
              icon: Icons.keyboard_arrow_left_rounded,
            ),
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: AnimatedOpacity(
              opacity: _currentPage == 0 ? 0 : 1,
              duration: context.theme.durations.pageElements,
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
