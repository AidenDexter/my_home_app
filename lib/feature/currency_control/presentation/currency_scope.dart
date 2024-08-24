import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

import '../../../core/services/service_locator/service_locator.dart';
import '../bloc/currency_control_bloc.dart';
import '../domain/entity/currency.dart';

@immutable
class CurrencyScope extends SingleChildStatelessWidget {
  const CurrencyScope({super.key});

  static void change(BuildContext context, {required Currency currency}) =>
      context.read<CurrencyControlBloc>().add(CurrencyControlEvent.change(currency: currency));

  static Currency currency(BuildContext context, {bool listen = true}) =>
      listen ? context.watch<CurrencyControlBloc>().state.currency : context.read<CurrencyControlBloc>().state.currency;

  static String currencySymbol(BuildContext context, {bool listen = true}) => listen
      ? (context.watch<CurrencyControlBloc>().state.currency == Currency.lari ? '₾' : r'$')
      : (context.read<CurrencyControlBloc>().state.currency == Currency.lari ? '₾' : r'$');

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => BlocProvider<CurrencyControlBloc>(
        create: (context) => getIt<CurrencyControlBloc>(),
        child: child,
      );
}
