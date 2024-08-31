import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

import '../../../core/services/service_locator/service_locator.dart';
import '../bloc/localization_control_bloc.dart';
import '../domain/locale_entity/locale_entity.dart';

@immutable
class LocalizationScope extends SingleChildStatelessWidget {
  const LocalizationScope({super.key});

  static Locale? localeOf(BuildContext context) =>
      context.watch<LocalizationControlBloc>().state.currentLocalization.toLocale;

  static String getLocaleCode(BuildContext context, {bool listen = true}) => listen
      ? context.watch<LocalizationControlBloc>().state.currentLocalization.languageCode
      : context.read<LocalizationControlBloc>().state.currentLocalization.languageCode;

  static void changeLocale(BuildContext context, {required Locale locale}) =>
      context.read<LocalizationControlBloc>().add(
            LocalizationControlEvent.changeLocalization(locale: LocaleEntity.fromLocale(locale)),
          );

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => BlocProvider<LocalizationControlBloc>(
        create: (context) => getIt<LocalizationControlBloc>(),
        child: child,
      );
}
