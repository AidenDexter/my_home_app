import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

import '../../../core/extension/src/amount.dart';
import '../../../core/services/service_locator/service_locator.dart';
import '../../search/domain/entity/search_response.dart';
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

  static String showPrice(BuildContext context, {required Price price, bool listen = true}) {
    final isLari = listen
        ? (context.watch<CurrencyControlBloc>().state.currency == Currency.lari)
        : (context.read<CurrencyControlBloc>().state.currency == Currency.lari);
    if (isLari) return '${price.first.priceTotal.toString().formatNumber()} ₾';
    return price.second.priceTotal.toString().formatNumber() + r' $';
  }

  static String showPriceSquare(BuildContext context, {required Price price, bool listen = true}) {
    final isLari = listen
        ? (context.watch<CurrencyControlBloc>().state.currency == Currency.lari)
        : (context.read<CurrencyControlBloc>().state.currency == Currency.lari);
    if (isLari) return '${price.first.priceSquare.toString().formatNumber()} ₾';
    return price.second.priceSquare.toString().formatNumber() + r' $';
  }

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => BlocProvider<CurrencyControlBloc>(
        create: (context) => getIt<CurrencyControlBloc>(),
        child: child,
      );
}
