import 'package:flutter/material.dart';

import '../../../../../core/extension/extensions.dart';
import '../../../../../core/ui_kit/range_text_field.dart';

class FloorFilters extends StatelessWidget {
  const FloorFilters({
    required this.floorFromController,
    required this.floorToController,
    super.key,
  });

  final TextEditingController floorFromController;
  final TextEditingController floorToController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(context.l10n.floor),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: RangeTextField(
                suffix: null,
                label: context.l10n.from,
                controller: floorFromController,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: RangeTextField(
                suffix: null,
                label: context.l10n.to,
                controller: floorToController,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
