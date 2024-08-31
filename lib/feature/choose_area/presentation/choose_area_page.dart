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
  final ValueNotifier<List<int>> selectedDistricts;
  final ValueNotifier<List<int>> selectedUrbans;
  final VoidCallback search;

  const ChooseAreaPage({
    required this.selectedCity,
    required this.selectedDistricts,
    required this.selectedUrbans,
    required this.search,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        title: Text(context.l10n.choose_location),
      ),
      body: BlocBuilder<ChooseAreaBloc, ChooseAreaState>(
        builder: (context, state) => state.map(
          progress: (_) => const Center(child: CircularProgressIndicator()),
          success: (state) => _DataLayout(
            data: state.data.data,
            selectedCity: selectedCity,
            selectedDistricts: selectedDistricts,
            selectedUrbans: selectedUrbans,
            search: search,
          ),
          error: (state) => ErrorBody(error: state.errorHandler, actions: const []),
        ),
      ),
    );
  }
}

class _DataLayout extends StatelessWidget {
  final ValueNotifier<int?> selectedCity;
  final ValueNotifier<List<int>> selectedDistricts;
  final ValueNotifier<List<int>> selectedUrbans;
  final VoidCallback search;
  const _DataLayout({
    required this.data,
    required this.selectedCity,
    required this.selectedDistricts,
    required this.selectedUrbans,
    required this.search,
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
                selectedDistricts: selectedDistricts,
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
                          selectedDistricts: selectedDistricts,
                          selectedUrbans: selectedUrbans,
                          districts: data.firstWhere((city) => city.id == selectedCity.value).districts!,
                        ),
                        child: Text(context.l10n.select_districts),
                      ),
                    ),
                    crossFadeState: _hasDistricts() ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                    duration: context.theme.durations.pageElements,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryElevatedButton.secondary(
                          child: Text(context.l10n.clear),
                          onPressed: () {
                            selectedCity.value = null;
                            selectedUrbans.value = [];
                            selectedDistricts.value = [];
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: PrimaryElevatedButton(
                          child: Text(context.l10n.search),
                          onPressed: selectedCity.value != null
                              ? () {
                                  context.pop();
                                  search();
                                }
                              : null,
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
    required this.selectedDistricts,
  });
  final Datum data;
  final ValueNotifier<int?> selectedCity;
  final ValueNotifier<List<int>> selectedDistricts;
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
          selectedDistricts.value = [];
          selectedUrbans.value = [];
        }
        selectedCity.value = data.id;
      },
      borderInactiveColor: context.theme.commonColors.neutralgrey10,
      child: Row(
        children: [
          Expanded(
            child: Text(
              data.translations.getDisplayName(context),
              style: context.theme.commonTextStyles.title2,
            ),
          ),
          AnimatedBuilder(
            animation: Listenable.merge([selectedCity, selectedDistricts]),
            builder: (context, child) {
              if (isSelected && selectedDistricts.value.isNotEmpty) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.theme.commonColors.green100,
                  ),
                  child: Text(
                    selectedDistricts.value.length.toString(),
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
