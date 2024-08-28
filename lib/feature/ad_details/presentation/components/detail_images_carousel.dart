import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extension/extensions.dart';
import '../../../../core/resources/assets.gen.dart';
import '../../../../core/router/routes_enum.dart';
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

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) return const SizedBox();
    final topPadding = MediaQuery.of(context).padding.top;
    return SizedBox(
      height: 340,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          GestureDetector(
            onTap: () {
              context.push(CommonRoutes.photoView.path, extra: {
                'initialIndex': _currentPage,
                'images': images,
              });
            },
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
            top: 12 + topPadding,
            left: 16,
            child: VipLabel(widget.item),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: context.theme.commonColors.black.withOpacity(0.5),
              ),
              margin: const EdgeInsets.only(bottom: 12),
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
