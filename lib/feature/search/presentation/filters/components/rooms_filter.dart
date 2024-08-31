import 'package:flutter/material.dart';

import '../../../../../core/ui_kit/multi_selection_card.dart';
import '../../../domain/entity/rooms.dart';

class RoomsFilter extends StatelessWidget {
  final ValueNotifier<List<Rooms>> roomsController;
  const RoomsFilter({required this.roomsController, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text('Комнаты'),
        const SizedBox(height: 8),
        AnimatedBuilder(
          animation: roomsController,
          builder: (context, child) => Text.rich(
            TextSpan(
              children: Rooms.values
                  .map(
                    (item) => WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4,bottom: 4,right: 8),
                        child: MultiSelectionCard(
                          isSelected: roomsController.value.contains(item),
                          onTap: (value) {
                            if (roomsController.value.contains(value)) {
                              roomsController.value = List.from(roomsController.value)..remove(value);
                            } else {
                              roomsController.value = List.from(roomsController.value)..add(value);
                            }
                          },
                          value: item,
                          title: item.title,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
