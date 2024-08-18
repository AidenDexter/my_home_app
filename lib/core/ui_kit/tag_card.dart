import 'package:flutter/material.dart';

import '../extension/extensions.dart';

class TagCard extends StatelessWidget {
  final String text;
  final Widget icon;
  const TagCard({
    required this.text,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.theme.commonColors.blue10,
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(width: 12),
            Text(
              text,
              style: context.theme.commonTextStyles.body2,
            ),
          ],
        ),
      ),
    );
  }
}
