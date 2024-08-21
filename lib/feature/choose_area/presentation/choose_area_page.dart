import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/extension/extensions.dart';
import '../../../core/ui_kit/error_page.dart';
import '../../../core/ui_kit/primary_app_bar.dart';
import '../../../core/ui_kit/primary_elevated_button.dart';
import '../../../core/ui_kit/single_selection_card.dart';
import '../bloc/choose_area_bloc.dart';
import '../domain/entity/choose_area_response.dart';
import 'components/choose_district_bottom_sheet.dart';

class ChooseAreaPage extends StatelessWidget {
  final ValueNotifier<int?> selectedCity;
  final ValueNotifier<List<int>> selectedDisctricts;
  final ValueNotifier<List<int>> selectedUrbans;

  const ChooseAreaPage({
    required this.selectedCity,
    required this.selectedDisctricts,
    required this.selectedUrbans,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(
        title: Text('Выбрать место'),
      ),
      body: BlocBuilder<ChooseAreaBloc, ChooseAreaState>(
        builder: (context, state) => state.map(
          progress: (_) => const Center(child: CircularProgressIndicator()),
          success: (state) => _DataLayout(
            data: state.data.data,
            selectedCity: selectedCity,
            selectedDisctricts: selectedDisctricts,
            selectedUrbans: selectedUrbans,
          ),
          error: (state) => ErrorBody(error: state.errorHandler, actions: const []),
        ),
      ),
    );
  }
}

class _DataLayout extends StatelessWidget {
  final ValueNotifier<int?> selectedCity;
  final ValueNotifier<List<int>> selectedDisctricts;
  final ValueNotifier<List<int>> selectedUrbans;
  const _DataLayout({
    required this.data,
    required this.selectedCity,
    required this.selectedDisctricts,
    required this.selectedUrbans,
  });

  final List<Datum> data;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return AnimatedBuilder(
      animation: selectedCity,
      builder: (context, _) => Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(right: 16, left: 16, bottom: bottomPadding + 80, top: 8),
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) => _CityCard(
                data: data[index],
                selectedCity: selectedCity,
                selectedUrbans: selectedUrbans,
                selectedDisctricts: selectedDisctricts,
              ),
              itemCount: data.length,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  AnimatedCrossFade(
                    firstChild: const SizedBox(width: double.infinity),
                    secondChild: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: PrimaryElevatedButton(
                        onPressed: () => ChooseDistrictBottomSheet.show(
                          context,
                          selectedDisctricts: selectedDisctricts,
                          selectedUrbans: selectedUrbans,
                          districts: data.firstWhere((city) => city.id == selectedCity.value).districts!,
                        ),
                        child: const Text('Выбрать районы'),
                      ),
                    ),
                    crossFadeState: _hasDistricts() ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                    duration: context.theme.durations.pageElements,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryElevatedButton.secondary(
                          child: const Text('Очистить'),
                          onPressed: () {
                            selectedCity.value = null;
                            selectedUrbans.value = [];
                            selectedDisctricts.value = [];
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: PrimaryElevatedButton(
                          child: const Text('Готово'),
                          onPressed: selectedCity.value != null ? context.pop : null,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _hasDistricts() {
    if (selectedCity.value == null) return false;

    final districts = data.firstWhere((city) => city.id == selectedCity.value).districts;
    return districts != null && districts.isNotEmpty;
  }
}

class _CityCard extends StatelessWidget {
  const _CityCard({
    required this.data,
    required this.selectedCity,
    required this.selectedUrbans,
    required this.selectedDisctricts,
  });
  final Datum data;
  final ValueNotifier<int?> selectedCity;
  final ValueNotifier<List<int>> selectedDisctricts;
  final ValueNotifier<List<int>> selectedUrbans;

  bool get hasDistricts => data.districts != null && (data.districts ?? []).isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final isSelected = data.id == selectedCity.value;
    return SingleSelectionCard(
      value: data.id,
      groupValue: selectedCity.value,
      onTap: (_) {
        if (selectedCity.value == data.id) {}
        if (data.id != selectedCity.value) {
          selectedDisctricts.value = [];
          selectedUrbans.value = [];
        }
        selectedCity.value = data.id;
      },
      borderInactiveColor: context.theme.commonColors.neutralgrey10,
      child: Row(
        children: [
          Expanded(
            child: Text(
              data.translations.ru.displayName,
              style: context.theme.commonTextStyles.title2,
            ),
          ),
          AnimatedBuilder(
            animation: Listenable.merge([selectedCity, selectedDisctricts]),
            builder: (context, child) {
              if (isSelected && selectedDisctricts.value.isNotEmpty) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.theme.commonColors.green100,
                  ),
                  child: Text(
                    selectedDisctricts.value.length.toString(),
                    style: context.theme.commonTextStyles.body2.copyWith(
                      color: context.theme.commonColors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 9,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
