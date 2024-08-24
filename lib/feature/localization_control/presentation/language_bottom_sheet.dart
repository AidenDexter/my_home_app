import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/ui_kit/primary_bottom_sheet.dart';
import '../../home/presentation/localization_card.dart';
import '../bloc/localization_control_bloc.dart';
import '../domain/locale_entity/locale_entity.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet._();

  static void show(BuildContext context) => PrimaryBottomSheet.show(
        builder: (context) => const LanguageBottomSheet._(),
        context: context,
        useRootNavigator: true,
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationControlBloc, LocalizationControlState>(builder: (context, state) {
      final localization = state.currentLocalization;
      return Column(
        children: List.generate(
          LocaleEntity.values.length,
          (index) {
            final localeEntity = LocaleEntity.values[index];
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    context.read<LocalizationControlBloc>().add(
                          LocalizationControlEvent.changeLocalization(locale: localeEntity),
                        );
                  },
                  child: LanguageChangeCard(
                    title: localeEntity.titleName,
                    leading: Radio<LocaleEntity>(
                      value: localeEntity,
                      groupValue: localization,
                      onChanged: null,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
