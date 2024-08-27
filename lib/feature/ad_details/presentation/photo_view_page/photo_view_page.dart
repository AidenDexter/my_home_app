import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../../core/extension/extensions.dart';
import '../../../../core/ui_kit/circle_button.dart';
import '../../../search/domain/entity/search_response.dart';

class PhotoViewPage extends StatefulWidget {
  final int initialIndex;
  final List<Images> images;
  const PhotoViewPage({
    required this.initialIndex,
    required this.images,
    super.key,
  });

  @override
  State<PhotoViewPage> createState() => _PhotoViewPageState();
}

class _PhotoViewPageState extends State<PhotoViewPage> with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  late final TabController _tabController;
  bool _isPageAnimating = false;

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.initialIndex);
    _tabController = TabController(initialIndex: widget.initialIndex, length: widget.images.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.commonColors;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
      child: Material(
        color: Colors.transparent,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(32),
                    ),
                    child: PhotoViewGallery.builder(
                      allowImplicitScrolling: true,
                      onPageChanged: (index) {
                        if (_isPageAnimating) return;
                        _tabController.animateTo(index);
                      },
                      pageController: _pageController,
                      scrollPhysics: const BouncingScrollPhysics(),
                      builder: (_, index) {
                        return PhotoViewGalleryPageOptions(
                          minScale: PhotoViewComputedScale.contained * 1,
                          maxScale: PhotoViewComputedScale.covered * 10,
                          imageProvider: CachedNetworkImageProvider(
                            widget.images[index].large,
                          ),
                          heroAttributes: PhotoViewHeroAttributes(
                            tag: widget.images[index],
                          ),
                        );
                      },
                      itemCount: widget.images.length,
                      loadingBuilder: (context, event) => const Center(
                        child: SizedBox.square(
                          dimension: 40,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedBuilder(
                  animation: _tabController,
                  builder: (context, child) {
                    return TabBar(
                      labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                      onTap: (index) {
                        _isPageAnimating = true;
                        _pageController
                            .animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut)
                            .then(
                              (_) => _isPageAnimating = false,
                            );
                      },
                      indicator: const BoxDecoration(),
                      dividerColor: Colors.transparent,
                      indicatorWeight: 0,
                      indicatorColor: Colors.transparent,
                      isScrollable: true,
                      tabs: [
                        for (int i = 0; i < widget.images.length; i++)
                          Container(
                            height: 80,
                            width: 80,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              border: _tabController.index == i
                                  ? Border.all(
                                      color: colors.green100, width: 2, strokeAlign: BorderSide.strokeAlignOutside)
                                  : null,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                imageUrl: widget.images[i].thumb,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                      ],
                      controller: _tabController,
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
            SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: const EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: colors.black.withOpacity(0.5),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  child: AnimatedBuilder(
                    animation: _tabController,
                    builder: (context, child) => Text(
                      '${_tabController.index + 1} / ${widget.images.length}',
                      style: context.theme.commonTextStyles.label.copyWith(
                        color: colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: SafeArea(
                child: CircleButton(
                  backgroundColor: colors.black.withOpacity(.4),
                  icon: Icon(
                    Icons.close_rounded,
                    color: colors.green10,
                  ),
                  onTap: context.pop,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark));
    _pageController.dispose();
    _tabController.dispose();
    super.dispose();
  }
}
