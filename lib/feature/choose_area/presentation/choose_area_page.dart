import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extension/extensions.dart';
import '../../../core/resources/assets.gen.dart';
import '../../../core/ui_kit/error_page.dart';
import '../../../core/ui_kit/primary_app_bar.dart';
import '../../../core/ui_kit/single_selection_card.dart';
import '../bloc/choose_area_bloc.dart';
import '../domain/entity/choose_area_response.dart';
import 'components/choose_district_bottom_sheet.dart';

class ChooseAreaPage extends StatelessWidget {
  const ChooseAreaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(
        title: Text('Выбрать место'),
      ),
      body: BlocBuilder<ChooseAreaBloc, ChooseAreaState>(
        builder: (context, state) => state.map(
          progress: (_) => const Center(child: CircularProgressIndicator()),
          success: (state) => _DataLayout(data: state.data.data),
          error: (state) => ErrorBody(error: state.errorHandler, actions: const []),
        ),
      ),
    );
  }
}

class _DataLayout extends StatefulWidget {
  const _DataLayout({required this.data});

  final List<Datum> data;

  @override
  State<_DataLayout> createState() => _DataLayoutState();
}

class _DataLayoutState extends State<_DataLayout> {
  late final ValueNotifier<int?> _selectedCity;
  late final ValueNotifier<List<int>> _selectedDisctricts;
  late final ValueNotifier<List<int>> _selectedUrbans;

  @override
  void initState() {
    _selectedCity = ValueNotifier(null);
    _selectedDisctricts = ValueNotifier([]);
    _selectedUrbans = ValueNotifier([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _selectedCity,
      builder: (context, _) => ListView.separated(
        padding: const EdgeInsets.only(right: 16, left: 16, bottom: 80, top: 8),
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) => _CityCard(
          data: widget.data[index],
          selectedCity: _selectedCity,
          selectedUrbans: _selectedUrbans,
          selectedDisctricts: _selectedDisctricts,
        ),
        itemCount: widget.data.length,
      ),
    );
  }

  @override
  void dispose() {
    _selectedCity.dispose();
    _selectedDisctricts.dispose();
    _selectedUrbans.dispose();
    super.dispose();
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
    return SingleSelectionCard(
      value: data.id,
      groupValue: selectedCity.value,
      onTap: (_) {
        if (data.id != selectedCity.value) {
          selectedDisctricts.value = [];
          selectedUrbans.value = [];
        }
        if (hasDistricts) {
          ChooseDistrictBottomSheet.show(
            context,
            selectedDisctricts: selectedDisctricts,
            selectedUrbans: selectedUrbans,
            districts: data.districts!,
          );
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
              if (data.id == selectedCity.value && selectedDisctricts.value.isNotEmpty) {
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
          if (hasDistricts)
            RotatedBox(
              child: Assets.icons.arrow.svg(
                colorFilter: ColorFilter.mode(
                  context.theme.commonColors.darkGrey30,
                  BlendMode.srcIn,
                ),
              ),
              quarterTurns: 2,
            ),
        ],
      ),
    );
  }
}
