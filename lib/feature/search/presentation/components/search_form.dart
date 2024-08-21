import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extension/extensions.dart';
import '../../../../core/resources/assets.gen.dart';
import '../../../../core/router/routes_enum.dart';
import '../../../../core/ui_kit/primary_elevated_button.dart';
import '../../../choose_area/presentation/choose_area_scope.dart';
import '../../domain/entity/deal_type.dart';
import '../../domain/entity/real_estate_type.dart';
import '../search_scope.dart';
import 'deal_type_bottom_sheet.dart';

class SearchForm extends StatelessWidget {
  const SearchForm({
    required this.dealType,
    required this.realEstateTypes,
    required this.selectedCity,
    required this.selectedDisctricts,
    required this.selectedUrbans,
    super.key,
  });

  final ValueNotifier<DealType?> dealType;
  final ValueNotifier<List<RealEstateType>> realEstateTypes;

  final ValueNotifier<int?> selectedCity;
  final ValueNotifier<List<int>> selectedDisctricts;
  final ValueNotifier<List<int>> selectedUrbans;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.commonColors;
    final textStyles = context.theme.commonTextStyles;
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
              _DealAndRealEstateType(dealType, realEstateTypes),
              Divider(height: 2, color: colors.neutralgrey10),
              _ChosenArea(
                selectedCity: selectedCity,
                selectedDisctricts: selectedDisctricts,
                selectedUrbans: selectedUrbans,
              ),
              Divider(height: 2, color: colors.neutralgrey10),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'ID, слово, телефон',
                  style: textStyles.body1.copyWith(color: colors.darkGrey30),
                ),
              ),
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
                  onPressed: () {},
                  child: const Text('Подробный фильтр'),
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: _clearAllFilters,
                child: Ink(
                  decoration: BoxDecoration(
                    border: Border.all(color: colors.neutralgrey10, width: 0.8),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Center(child: Assets.icons.delete.svg()),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        PrimaryElevatedButton.icon(
          onPressed: () => SearchScope.search(context),
          icon: Assets.navBar.search.svg(
            colorFilter: ColorFilter.mode(colors.white, BlendMode.srcIn),
          ),
          child: const Text('Поиск'),
        ),
      ],
    );
  }

  void _clearAllFilters() {
    dealType.value = null;
    realEstateTypes.value = [];

    selectedCity.value = null;
    selectedDisctricts.value = [];
    selectedUrbans.value = [];
  }
}

class _ChosenArea extends StatelessWidget {
  const _ChosenArea({
    required this.selectedCity,
    required this.selectedDisctricts,
    required this.selectedUrbans,
  });

  final ValueNotifier<int?> selectedCity;
  final ValueNotifier<List<int>> selectedDisctricts;
  final ValueNotifier<List<int>> selectedUrbans;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.commonColors;
    final textStyles = context.theme.commonTextStyles;
    return InkWell(
      onTap: () => context.push(
        CommonRoutes.chooseArea.path,
        extra: {
          'city': selectedCity,
          'disctricts': selectedDisctricts,
          'urbans': selectedUrbans,
        },
      ),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: AnimatedBuilder(
            animation: Listenable.merge([selectedCity, selectedDisctricts]),
            builder: (context, child) {
              if (selectedCity.value == null) return child!;

              if (selectedDisctricts.value.isNotEmpty) {
                final res = <String>[];
                for (final item in selectedDisctricts.value) {
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
  const _DealAndRealEstateType(this.dealType, this.realEstateTypes);

  final ValueNotifier<DealType?> dealType;
  final ValueNotifier<List<RealEstateType>> realEstateTypes;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.commonColors;
    final textStyles = context.theme.commonTextStyles;
    return InkWell(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      onTap: () => DealTypeBottomSheet.show(context, dealType: dealType, realEstateTypes: realEstateTypes),
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
