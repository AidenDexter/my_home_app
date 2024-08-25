import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extension/extensions.dart';
import '../../../../core/resources/assets.gen.dart';
import '../../../../core/ui_kit/column_builder.dart';
import '../../../../core/ui_kit/primary_bottom_sheet.dart';
import '../../../../core/ui_kit/primary_check_box_2.dart';
import '../../domain/entity/choose_area_response.dart';

class ChooseDistrictBottomSheet extends StatelessWidget {
  final ValueNotifier<List<int>> selectedDisctricts;
  final ValueNotifier<List<int>> selectedUrbans;
  final List<Datum> districts;
  const ChooseDistrictBottomSheet._(this.selectedDisctricts, this.selectedUrbans, this.districts);

  static void show(
    BuildContext context, {
    required ValueNotifier<List<int>> selectedDisctricts,
    required ValueNotifier<List<int>> selectedUrbans,
    required List<Datum> districts,
  }) =>
      PrimaryBottomSheet.show(
        context: context,
        builder: (context) => ChooseDistrictBottomSheet._(
          selectedDisctricts,
          selectedUrbans,
          districts,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Выбрать район:', //TODO: добавить локализацию
                  style: context.theme.commonTextStyles.title1,
                ),
              ),
              TextButton(
                onPressed: context.pop,
                child: const Text('Закрыть'), //TODO: добавить локализацию
              ),
            ],
          ),
          const SizedBox(height: 8),
          ColumnBuilder.separator(
            itemBuilder: (context, index) => _DistrictCard(
              districts[index],
              selectedDisctricts,
              selectedUrbans,
            ),
            itemCount: districts.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
          ),
        ],
      ),
    );
  }
}

class _DistrictCard extends StatefulWidget {
  final Datum district;
  final ValueNotifier<List<int>> selectedDisctricts;
  final ValueNotifier<List<int>> selectedUrbans;
  const _DistrictCard(
    this.district,
    this.selectedDisctricts,
    this.selectedUrbans,
  );

  @override
  State<_DistrictCard> createState() => _DistrictCardState();
}

class _DistrictCardState extends State<_DistrictCard> {
  ValueNotifier<List<int>> get selectedDisctricts => widget.selectedDisctricts;
  ValueNotifier<List<int>> get selectedUrbans => widget.selectedUrbans;

  Datum get district => widget.district;

  bool get _isOpenable => district.urbans != null && (district.urbans ?? []).isNotEmpty;
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.commonColors;
    return AnimatedBuilder(
        animation: Listenable.merge([selectedDisctricts, selectedUrbans]),
        builder: (context, child) {
          return Ink(
            decoration: BoxDecoration(
              color: colors.neutralgrey3,
              border: Border.all(color: colors.neutralgrey10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    if (_isOpenable) {
                      setState(() => _isOpen = !_isOpen);
                      return;
                    }
                    if (selectedDisctricts.value.contains(district.id)) {
                      selectedDisctricts.value = List.from(selectedDisctricts.value)..remove(district.id);
                    } else {
                      selectedDisctricts.value = List.from(selectedDisctricts.value)..add(district.id);
                    }
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                      color: colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        PrimaryCheckbox2(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          value: _checkBoxState(),
                          onChanged: (_) {
                            if (_isOpenable) {
                              if (selectedDisctricts.value.contains(district.id)) {
                                selectedDisctricts.value = List.from(selectedDisctricts.value)..remove(district.id);
                                final urbans = selectedUrbans.value;
                                for (final element in district.urbans!) {
                                  if (urbans.contains(element.id)) {
                                    urbans.remove(element.id);
                                  }
                                }
                                selectedUrbans.value = List.from(urbans);
                              } else {
                                selectedDisctricts.value = List.from(selectedDisctricts.value)..add(district.id);
                                selectedUrbans.value = List.from(selectedUrbans.value)
                                  ..addAll(district.urbans!.map((e) => e.id));
                              }
                              return;
                            }
                            if (selectedDisctricts.value.contains(district.id)) {
                              selectedDisctricts.value = List.from(selectedDisctricts.value)..remove(district.id);
                            } else {
                              selectedDisctricts.value = List.from(selectedDisctricts.value)..add(district.id);
                            }
                          },
                          tristate: _isOpenable,
                        ),
                        Expanded(
                          child: Text(district.translations.ru.displayName),
                        ),
                        if (_isOpenable) ...[
                          AnimatedRotation(
                            turns: _isOpen ? 0.25 : -0.25,
                            duration: context.theme.durations.pageElements,
                            child: Assets.icons.arrowLeft.svg(
                              colorFilter: ColorFilter.mode(
                                context.theme.commonColors.neutralgrey10,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                        ],
                      ],
                    ),
                  ),
                ),
                if (_isOpenable)
                  AnimatedCrossFade(
                    firstChild: Padding(
                      padding: const EdgeInsets.all(8),
                      child: ColumnBuilder.separator(
                        itemBuilder: (context, index) {
                          final urban = district.urbans![index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () => _onUrbanTap(urban.id),
                              child: Ink(
                                decoration: BoxDecoration(
                                  color: colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    PrimaryCheckbox2(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                      value: selectedUrbans.value.contains(urban.id),
                                      onChanged: (_) => _onUrbanTap(urban.id),
                                      tristate: _isOpenable,
                                    ),
                                    Expanded(
                                      child: Text(district.urbans![index].translations.ru.displayName),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: district.urbans?.length ?? 0,
                        separatorBuilder: (context, index) => const SizedBox(height: 8),
                      ),
                    ),
                    secondChild: const SizedBox.shrink(),
                    crossFadeState: _isOpen ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                    duration: context.theme.durations.pageElements,
                  ),
              ],
            ),
          );
        });
  }

  void _onUrbanTap(int urbanId) {
    if (selectedUrbans.value.contains(urbanId)) {
      selectedUrbans.value = List.from(selectedUrbans.value)..remove(urbanId);
      if (!_isSelectedOneUrbanFromDistrict()) {
        selectedDisctricts.value = List.from(selectedDisctricts.value)..remove(district.id);
      }
      return;
    }
    if (!selectedDisctricts.value.contains(district.id)) {
      selectedDisctricts.value = List.from(selectedDisctricts.value)..add(district.id);
    }
    selectedUrbans.value = List.from(selectedUrbans.value)..add(urbanId);
  }

  bool? _checkBoxState() {
    if (!_isOpenable) return selectedDisctricts.value.contains(district.id);

    if (selectedDisctricts.value.contains(district.id)) {
      if (selectedUrbans.value.containsAll(district.urbans!.map((e) => e.id).toList())) return true;
      return null;
    }

    return false;
  }

  bool _isSelectedOneUrbanFromDistrict() {
    for (final urban in district.urbans ?? <Datum>[]) {
      if (selectedUrbans.value.contains(urban.id)) {
        return true;
      }
    }
    return false;
  }
}

extension on List<int> {
  bool containsAll(List<int> list) {
    for (final element in list) {
      if (!contains(element)) {
        return false;
      }
    }
    return true;
  }
}
