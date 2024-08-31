import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extension/extensions.dart';
import '../../../../core/resources/assets.gen.dart';
import '../../../../core/ui_kit/multi_selection_card.dart';
import '../../../../core/ui_kit/primary_app_bar.dart';
import '../../../../core/ui_kit/primary_elevated_button.dart';
import '../../../../core/ui_kit/range_text_field.dart';
import '../../../../core/ui_kit/single_selection_card.dart';
import '../../../currency_control/presentation/currency_scope.dart';
import '../../../currency_control/presentation/currency_switcher.dart';
import '../../domain/entity/deal_type.dart';
import '../../domain/entity/real_estate_type.dart';

class FiltersPage extends StatefulWidget {
  final ValueNotifier<DealType?> dealType;
  final ValueNotifier<List<RealEstateType>> realEstateTypes;
  final TextEditingController priceFromController;
  final TextEditingController priceToController;
  final TextEditingController areaFromController;
  final TextEditingController areaToController;
  final TextEditingController floorFromController;
  final TextEditingController floorToController;
  final ValueNotifier<bool> notFirstFloorController;
  final ValueNotifier<bool> notLastFloorController;
  final ValueNotifier<bool> isLastFloorController;
  final VoidCallback search;

  const FiltersPage({
    required this.dealType,
    required this.realEstateTypes,
    required this.search,
    required this.priceFromController,
    required this.priceToController,
    required this.areaFromController,
    required this.areaToController,
    required this.floorFromController,
    required this.floorToController,
    required this.notFirstFloorController,
    required this.notLastFloorController,
    required this.isLastFloorController,
    super.key,
  });

  @override
  State<FiltersPage> createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  @override
  void initState() {
    widget.realEstateTypes.addListener(onRealEstateChange);
    super.initState();
  }

  void onRealEstateChange() {
    widget.floorFromController.text = '';
    widget.floorToController.text = '';
    widget.notFirstFloorController.value = false;
    widget.notLastFloorController.value = false;
    widget.isLastFloorController.value = false;
  }

  @override
  void dispose() {
    widget.realEstateTypes.removeListener(onRealEstateChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.commonColors;
    final currencySymbol = CurrencyScope.currencySymbol(context);
    return Scaffold(
      appBar: PrimaryAppBar(
        title: Text(context.l10n.detailed_filter),
      ),
      body: Column(
        children: [
          DefaultTextStyle(
            style: context.theme.commonTextStyles.title3,
            child: Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text(context.l10n.transaction_type),
                  const SizedBox(height: 8),
                  AnimatedBuilder(
                      animation: widget.dealType,
                      builder: (context, child) {
                        return Text.rich(
                          TextSpan(
                              children: DealType.values
                                  .map(
                                    (e) => WidgetSpan(
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 8, right: 8),
                                        child: SingleSelectionCard(
                                          groupValue: widget.dealType.value,
                                          onTap: (value) => widget.dealType.value = value,
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
                    animation: widget.realEstateTypes,
                    builder: (context, child) {
                      return Text.rich(
                        TextSpan(
                          children: RealEstateType.values
                              .map(
                                (e) => WidgetSpan(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8, right: 8),
                                    child: MultiSelectionCard(
                                      isSelected: widget.realEstateTypes.value.contains(e),
                                      onTap: _onRealEstateTap,
                                      value: e,
                                      title: e.toLocalizeString(context),
                                      icon: _realEstateTypeToIcon(context, e, widget.realEstateTypes.value.contains(e)),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: context.l10n.full_price),
                        const WidgetSpan(
                          child: Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: CurrencySwitcher(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: RangeTextField(
                          suffix: currencySymbol,
                          label: context.l10n.from,
                          controller: widget.priceFromController,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: RangeTextField(
                          suffix: currencySymbol,
                          label: context.l10n.to,
                          controller: widget.priceToController,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(context.l10n.area),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: RangeTextField(
                          suffix: context.l10n.square_meter,
                          label: context.l10n.from,
                          controller: widget.areaFromController,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: RangeTextField(
                          suffix: context.l10n.square_meter,
                          label: context.l10n.to,
                          controller: widget.areaToController,
                        ),
                      ),
                    ],
                  ),
                  AnimatedBuilder(
                    animation: widget.realEstateTypes,
                    builder: (context, child) {
                      if (widget.realEstateTypes.value.isEmpty) return const SizedBox.shrink();

                      final listOfTypesFilters = widget.realEstateTypes.value.map((e) => e.filters).toList();

                      // Преобразуем первый список в множество
                      var firstTypeFilters = listOfTypesFilters[0].toSet();

                      // Пересекаем его с остальными списками
                      for (var i = 1; i < listOfTypesFilters.length; i++) {
                        firstTypeFilters = firstTypeFilters.intersection(listOfTypesFilters[i].toSet());
                      }

                      return Column(
                        children: firstTypeFilters
                            .map(
                              (e) => _filters[e] ?? Text('Фильтр $e отсутствует в списке'),
                            )
                            .toList(),
                      );
                    },
                  ),
                ],
              ),
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
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: PrimaryElevatedButton.secondary(
                      onPressed: _clearAllFilters,
                      child: Text(context.l10n.clear),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: PrimaryElevatedButton(
                      onPressed: () {
                        context.pop();
                        widget.search();
                      },
                      child: Text(context.l10n.search),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _clearAllFilters() {
    widget.dealType.value = null;
    widget.realEstateTypes.value = [];

    widget.priceFromController.text = '';
    widget.priceToController.text = '';
    widget.areaFromController.text = '';
    widget.areaToController.text = '';
    widget.floorFromController.text = '';
    widget.floorToController.text = '';
    widget.notFirstFloorController.value = false;
    widget.notLastFloorController.value = false;
    widget.isLastFloorController.value = false;
  }

  void _onRealEstateTap(RealEstateType value) {
    if (widget.realEstateTypes.value.contains(value)) {
      widget.realEstateTypes.value = List.from(widget.realEstateTypes.value)..remove(value);
      return;
    }
    widget.realEstateTypes.value = List.from(widget.realEstateTypes.value)..add(value);
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

  late final _filters = {
    'floor': FloorFilters(
      floorFromController: widget.floorFromController,
      floorToController: widget.floorToController,
      notFirstFloorController: widget.notFirstFloorController,
      notLastFloorController: widget.notLastFloorController,
      isLastFloorController: widget.isLastFloorController,
    ),
  };
}

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
                          title: context.l10n.last,
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
                          title: context.l10n.not_last,
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
                          title: context.l10n.not_first,
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
