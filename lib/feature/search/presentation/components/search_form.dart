import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extension/extensions.dart';
import '../../../../core/resources/assets.gen.dart';
import '../../../../core/router/routes_enum.dart';
import '../../../../core/ui_kit/primary_elevated_button.dart';
import '../../../choose_area/presentation/choose_area_scope.dart';
import '../../domain/entity/deal_type.dart';
import '../../domain/entity/real_estate_type.dart';
import 'deal_type_bottom_sheet.dart';

class SearchForm extends StatelessWidget {
  const SearchForm({
    required this.dealType,
    required this.realEstateTypes,
    required this.selectedCity,
    required this.selectedDistricts,
    required this.selectedUrbans,
    required this.search,
    required this.searchController,
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

  final ValueNotifier<DealType?> dealType;
  final ValueNotifier<List<RealEstateType>> realEstateTypes;

  final ValueNotifier<int?> selectedCity;
  final ValueNotifier<List<int>> selectedDistricts;
  final ValueNotifier<List<int>> selectedUrbans;

  final TextEditingController searchController;
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

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.commonColors;
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: colors.green100, width: 2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _DealAndRealEstateType(dealType, realEstateTypes, search),
              Divider(height: 2, color: colors.neutralgrey10),
              _ChosenArea(
                selectedCity: selectedCity,
                selectedDistricts: selectedDistricts,
                selectedUrbans: selectedUrbans,
                search: search,
              ),
              Divider(height: 2, color: colors.neutralgrey10),
              _SearchText(searchController),
            ],
          ),
        ),
        const SizedBox(height: 16),
        IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: PrimaryElevatedButton.secondary(
                  icon: Assets.icons.filters.svg(
                    height: 20,
                  ),
                  onPressed: () {
                    context.push(CommonRoutes.filters.path, extra: {
                      'search': search,
                      'dealType': dealType,
                      'realEstateTypes': realEstateTypes,
                      'priceFrom': priceFromController,
                      'priceTo': priceToController,
                      'areaFrom': areaFromController,
                      'areaTo': areaToController,
                      'floorFrom': floorFromController,
                      'floorTo': floorToController,
                      'notFirstFloor': notFirstFloorController,
                      'notLastFloor': notLastFloorController,
                      'isLastFloor': isLastFloorController,
                    });
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Подробный фильтр'),
                      const SizedBox(width: 6),
                      AnimatedBuilder(
                          animation: _listenAll,
                          builder: (context, _) {
                            if (_usedFiltersCount == 0) return const SizedBox.shrink();
                            return Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colors.yellow,
                              ),
                              padding: const EdgeInsets.all(6),
                              child: Text(
                                '$_usedFiltersCount',
                                style: context.theme.commonTextStyles.label.copyWith(
                                  color: colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  _clearAllFilters();
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: colors.neutralgrey10, width: 0.8),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.center,
                  child: Assets.icons.delete.svg(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        PrimaryElevatedButton.icon(
          onPressed: () {
            search();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          icon: Assets.navBar.search.svg(
            colorFilter: ColorFilter.mode(colors.white, BlendMode.srcIn),
          ),
          child: const Text('Поиск'),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  void _clearAllFilters() {
    dealType.value = null;
    realEstateTypes.value = [];

    selectedCity.value = null;
    selectedDistricts.value = [];
    selectedUrbans.value = [];

    searchController.text = '';
    priceFromController.text = '';
    priceToController.text = '';
    areaFromController.text = '';
    areaToController.text = '';
    floorFromController.text = '';
    floorToController.text = '';

    notFirstFloorController.value = false;
    notLastFloorController.value = false;
    isLastFloorController.value = false;
  }

  Listenable get _listenAll => Listenable.merge([
        dealType,
        realEstateTypes,
        selectedCity,
        selectedDistricts,
        selectedUrbans,
        searchController,
        priceFromController,
        priceToController,
        areaFromController,
        areaToController,
        floorFromController,
        floorToController,
        notFirstFloorController,
        notLastFloorController,
        isLastFloorController,
      ]);

  int get _usedFiltersCount {
    var res = 0;
    if (dealType.value != null) res++;
    if (realEstateTypes.value.isNotEmpty) res++;
    if (selectedCity.value != null) res++;
    if (selectedDistricts.value.isNotEmpty) res++;
    if (selectedUrbans.value.isNotEmpty) res++;
    if (searchController.text.isNotEmpty) res++;
    if (priceFromController.text.isNotEmpty) res++;
    if (priceToController.text.isNotEmpty) res++;
    if (areaFromController.text.isNotEmpty) res++;
    if (areaToController.text.isNotEmpty) res++;
    if (floorFromController.text.isNotEmpty) res++;
    if (floorToController.text.isNotEmpty) res++;
    if (notFirstFloorController.value) res++;
    if (notLastFloorController.value) res++;
    if (isLastFloorController.value) res++;
    return res;
  }
}

class _SearchText extends StatelessWidget {
  final TextEditingController searchController;
  const _SearchText(this.searchController);

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.commonColors;
    final textStyles = context.theme.commonTextStyles;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      child: TextField(
        controller: searchController,
        style: textStyles.body1,
        cursorColor: colors.green100,
        decoration: InputDecoration(
          hintText: 'ID, слово, телефон',
          hintStyle: textStyles.body1.copyWith(color: colors.darkGrey30),
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
        ),
      ),
    );
  }
}

class _ChosenArea extends StatelessWidget {
  const _ChosenArea({
    required this.selectedCity,
    required this.selectedDistricts,
    required this.selectedUrbans,
    required this.search,
  });

  final ValueNotifier<int?> selectedCity;
  final ValueNotifier<List<int>> selectedDistricts;
  final ValueNotifier<List<int>> selectedUrbans;
  final VoidCallback search;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.commonColors;
    final textStyles = context.theme.commonTextStyles;
    return InkWell(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        context.push(
          CommonRoutes.chooseArea.path,
          extra: {
            'city': selectedCity,
            'districts': selectedDistricts,
            'urbans': selectedUrbans,
            'search': search,
          },
        );
      },
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: AnimatedBuilder(
            animation: Listenable.merge([selectedCity, selectedDistricts]),
            builder: (context, child) {
              if (selectedCity.value == null) return child!;

              if (selectedDistricts.value.isNotEmpty) {
                final res = <String>[];
                for (final item in selectedDistricts.value) {
                  final district = ChooseAreaScope.districtById(
                    context,
                    cityId: selectedCity.value!,
                    districtId: item,
                  );
                  if (district == null) continue;
                  res.add(district.translations.ru.displayName);
                }
                return Text(
                  res.join(', '),
                  style: textStyles.body1,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                );
              }

              final city = ChooseAreaScope.cityById(context, selectedCity.value!);
              if (city == null) return child!;
              return Text(city.translations.ru.displayName, style: textStyles.body1);
            },
            child: Text(
              'Город, район',
              style: textStyles.body1.copyWith(color: colors.darkGrey30),
            ),
          ),
        ),
      ),
    );
  }
}

class _DealAndRealEstateType extends StatelessWidget {
  const _DealAndRealEstateType(this.dealType, this.realEstateTypes, this.search);

  final ValueNotifier<DealType?> dealType;
  final ValueNotifier<List<RealEstateType>> realEstateTypes;
  final VoidCallback search;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.commonColors;
    final textStyles = context.theme.commonTextStyles;
    return InkWell(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        DealTypeBottomSheet.show(
          context,
          dealType: dealType,
          realEstateTypes: realEstateTypes,
          search: search,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            AnimatedBuilder(
              animation: Listenable.merge([dealType, realEstateTypes]),
              builder: (context, child) {
                var dealTypeText = 'Тип сделки';
                if (dealType.value != null) dealTypeText = dealType.value!.title;

                var realEstateTypesText = 'Тип недв. имущества';
                if (realEstateTypes.value.isNotEmpty) {
                  realEstateTypesText = 'Тип: ${realEstateTypes.value.map((e) => e.title).join(', ')}';
                }
                return Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dealTypeText,
                        style: textStyles.body1.copyWith(color: colors.darkGrey30, fontSize: 10),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        realEstateTypesText,
                        style: textStyles.body1,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            ),
            Icon(Icons.keyboard_arrow_down_rounded, color: colors.darkGrey100),
          ],
        ),
      ),
    );
  }
}
