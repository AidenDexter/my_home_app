import 'package:flutter/material.dart';

import '../../../../../core/ui_kit/multi_selection_card.dart';
import '../../../../../core/ui_kit/range_text_field.dart';

class FloorFilters extends StatelessWidget {
  const FloorFilters({
    required this.floorFromController,
    required this.floorToController,
    required this.notFirstFloorController,
    required this.notLastFloorController,
    required this.isLastFloorController,
    super.key,
  });

  final TextEditingController floorFromController;
  final TextEditingController floorToController;
  final ValueNotifier<bool> notFirstFloorController;
  final ValueNotifier<bool> notLastFloorController;
  final ValueNotifier<bool> isLastFloorController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text('Этаж'),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: RangeTextField(
                suffix: null,
                label: 'от',
                controller: floorFromController,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: RangeTextField(
                suffix: null,
                label: 'до',
                controller: floorToController,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        AnimatedBuilder(
            animation: Listenable.merge([notFirstFloorController, notLastFloorController, isLastFloorController]),
            builder: (context, child) {
              return Text.rich(
                TextSpan(
                  children: [
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: MultiSelectionCard(
                          isSelected: isLastFloorController.value,
                          onTap: (_) {
                            isLastFloorController.value = !isLastFloorController.value;
                            notLastFloorController.value = false;
                          },
                          value: true,
                          title: 'Последний',
                        ),
                      ),
                    ),
                    const WidgetSpan(child: SizedBox(width: 8)),
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: MultiSelectionCard(
                          isSelected: notLastFloorController.value,
                          onTap: (_) {
                            notLastFloorController.value = !notLastFloorController.value;
                            isLastFloorController.value = false;
                          },
                          value: true,
                          title: 'Не последний',
                        ),
                      ),
                    ),
                    const WidgetSpan(child: SizedBox(width: 8)),
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: MultiSelectionCard(
                          isSelected: notFirstFloorController.value,
                          onTap: (_) => notFirstFloorController.value = !notFirstFloorController.value,
                          value: true,
                          title: 'Не первый',
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ],
    );
  }
}
