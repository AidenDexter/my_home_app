import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extension/extensions.dart';
import '../../../../core/ui_kit/multi_selection_card.dart';
import '../../../../core/ui_kit/primary_bottom_sheet.dart';
import '../../../../core/ui_kit/primary_elevated_button.dart';
import '../../../../core/ui_kit/single_selection_card.dart';
import '../../domain/entity/deal_type.dart';
import '../../domain/entity/real_estate_type.dart';

class DealTypeBottomSheet extends StatelessWidget {
  final ValueNotifier<DealType?> dealType;
  final ValueNotifier<List<RealEstateType>> realEstateTypes;
  const DealTypeBottomSheet._(this.dealType, this.realEstateTypes);

  static void show(
    BuildContext context, {
    required ValueNotifier<DealType?> dealType,
    required ValueNotifier<List<RealEstateType>> realEstateTypes,
  }) =>
      PrimaryBottomSheet.show(
        context: context,
        useRootNavigator: true,
        builder: (context) => DealTypeBottomSheet._(dealType, realEstateTypes),
      );

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.commonColors;
    return DefaultTextStyle(
      style: context.theme.commonTextStyles.title3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Expanded(child: Text('Выберите параметры')),
                InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: context.pop,
                  child: Ink(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: colors.neutralgrey5,
                    ),
                    child: const Icon(Icons.close, size: 18),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Divider(height: 1, thickness: 0.5, color: colors.neutralgrey10),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Тип сделки'),
                const SizedBox(height: 8),
                AnimatedBuilder(
                    animation: dealType,
                    builder: (context, child) {
                      return Text.rich(
                        TextSpan(
                            children: DealType.values
                                .map(
                                  (e) => WidgetSpan(
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 8, right: 8),
                                      child: SingleSelectionCard(
                                        groupValue: dealType.value,
                                        onTap: (value) => dealType.value = value,
                                        value: e,
                                        title: e.title,
                                      ),
                                    ),
                                  ),
                                )
                                .toList()),
                      );
                    }),
                const SizedBox(height: 8),
                const Text('Тип недв. имущества'),
                const SizedBox(height: 8),
                AnimatedBuilder(
                  animation: realEstateTypes,
                  builder: (context, child) {
                    return Text.rich(
                      TextSpan(
                        children: RealEstateType.values
                            .map(
                              (e) => WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 8, right: 8),
                                  child: MultiSelectionCard(
                                    isSelected: realEstateTypes.value.contains(e),
                                    onTap: _onRealEstateTap,
                                    value: e,
                                    title: e.title,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.white,
              border: Border(
                top: BorderSide(width: 0.5, color: colors.neutralgrey10),
              ),
              boxShadow: [
                BoxShadow(
                  color: colors.neutralgrey10,
                  blurRadius: 4,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: PrimaryElevatedButton.secondary(
                    onPressed: () {
                      dealType.value = null;
                      realEstateTypes.value = [];
                    },
                    child: const Text('Очистить'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: PrimaryElevatedButton(
                    onPressed: context.pop,
                    child: const Text('Поиск'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _onRealEstateTap(RealEstateType value) {
    if (realEstateTypes.value.contains(value)) {
      realEstateTypes.value = List.from(realEstateTypes.value)..remove(value);
      return;
    }
    realEstateTypes.value = List.from(realEstateTypes.value)..add(value);
  }
}
