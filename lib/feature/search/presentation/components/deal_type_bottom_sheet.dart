import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extension/extensions.dart';
import '../../../../core/resources/assets.gen.dart';
import '../../../../core/ui_kit/multi_selection_card.dart';
import '../../../../core/ui_kit/primary_bottom_sheet.dart';
import '../../../../core/ui_kit/primary_elevated_button.dart';
import '../../../../core/ui_kit/single_selection_card.dart';
import '../../domain/entity/deal_type.dart';
import '../../domain/entity/real_estate_type.dart';

class DealTypeBottomSheet extends StatelessWidget {
  final ValueNotifier<DealType?> dealType;
  final ValueNotifier<List<RealEstateType>> realEstateTypes;
  final VoidCallback search;
  const DealTypeBottomSheet._(this.dealType, this.realEstateTypes, this.search);

  static void show(
    BuildContext context, {
    required ValueNotifier<DealType?> dealType,
    required ValueNotifier<List<RealEstateType>> realEstateTypes,
    required VoidCallback search,
  }) =>
      PrimaryBottomSheet.show(
        context: context,
        useRootNavigator: true,
        builder: (context) => DealTypeBottomSheet._(dealType, realEstateTypes, search),
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
                Expanded(child: Text(context.l10n.select_options)),
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
                Text(context.l10n.transaction_type),
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
                                        title: e.toLocalizeString(context),
                                      ),
                                    ),
                                  ),
                                )
                                .toList()),
                      );
                    }),
                const SizedBox(height: 8),
                Text(context.l10n.real_estate_type),
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
                                    title: e.toLocalizeString(context),
                                    icon: _realEstateTypeToIcon(context, e, realEstateTypes.value.contains(e)),
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
                    child: Text(context.l10n.clear),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: PrimaryElevatedButton(
                    onPressed: () {
                      context.pop();
                      search();
                    },
                    child: Text(context.l10n.search),
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

  Widget _realEstateTypeToIcon(BuildContext context, RealEstateType type, bool isSelected) {
    final colors = context.theme.commonColors;
    late final SvgGenImage asset;
    switch (type) {
      case RealEstateType.apartments:
        asset = Assets.icons.apartments;
      case RealEstateType.houses:
        asset = Assets.icons.houses;
      case RealEstateType.countryHouses:
        asset = Assets.icons.countryHouses;
      case RealEstateType.hotels:
        asset = Assets.icons.hotels;
      case RealEstateType.landPlots:
        asset = Assets.icons.landPlots;
      case RealEstateType.commercial:
        asset = Assets.icons.commercial;
    }
    return asset.svg(
      colorFilter: ColorFilter.mode(
        isSelected ? colors.white : colors.darkGrey100,
        BlendMode.srcIn,
      ),
    );
  }
}
