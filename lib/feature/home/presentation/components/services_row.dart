import 'package:flutter/material.dart';

import '../../../../core/extension/extensions.dart';
import '../../../../core/resources/assets.gen.dart';

class ServicesRow extends StatelessWidget {
  const ServicesRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 16),
          _ServiceCard(
            onTap: () {},
            name: context.l10n.valuation,
            image: Assets.images.rate,
          ),
          const SizedBox(width: 16),
          _ServiceCard(
            onTap: () {},
            name: context.l10n.measurement,
            image: Assets.images.measurement,
          ),
          const SizedBox(width: 16),
          _ServiceCard(
            onTap: () {},
            name: context.l10n.photo_service,
            image: Assets.images.photoservice,
          ),
          const SizedBox(width: 16),
          _ServiceCard(
            onTap: () {},
            name: context.l10n.mortgage,
            image: Assets.images.mortgageCalc,
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final AssetGenImage image;
  final String name;
  final VoidCallback onTap;
  const _ServiceCard({
    required this.image,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Material(
        color: context.theme.commonColors.blue10,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            width: 130,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  image.image(),
                  const SizedBox(height: 8),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      name,
                      style: context.theme.commonTextStyles.title1.copyWith(fontSize: 15),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
