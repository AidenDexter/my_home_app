import 'package:flutter/material.dart';

import '../../../core/resources/assets.gen.dart';
import '../../search/domain/entity/search_response.dart';
import 'components/detail_images_carousel.dart';

class AdDetailsPage extends StatelessWidget {
  final SearchItem item;
  const AdDetailsPage({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: DetailImagesCarousel(item),
          ),
          // SliverList(
          //   delegate: SliverChildListDelegate(
          //     [
          //       Row(children: [
          //         Assets.icons.calendar.svg(),
          //         Assets.icons.eye.svg(),
          //       ],)
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
