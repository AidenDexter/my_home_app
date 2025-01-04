import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/service_locator/service_locator.dart';
import '../../currency_control/presentation/currency_scope.dart';
import '../../localization_control/presentation/localization_scope.dart';
import '../bloc/search_bloc.dart';
import '../domain/entity/search_response.dart';

@immutable
class SearchScope extends StatelessWidget {
  final Widget child;

  const SearchScope({required this.child, super.key});

  static void search(
    BuildContext context, {
    required int? cityId,
    required int? dealType,
    required List<int> realEstateTypes,
    required List<int> districts,
    required List<int> urbans,
    required String searchText,
    required String priceFrom,
    required String priceTo,
    required String areaFrom,
    required String areaTo,
    required String floorFrom,
    required String floorTo,
    required bool notFirstFloor,
    required bool notLastFloor,
    required bool isLastFloor,
    required List<int> rooms,
  }) =>
      context.read<SearchBloc>().add(SearchEvent.search(
            locale: LocalizationScope.getLocaleCode(context, listen: false),
            cityId: cityId,
            dealType: dealType,
            districts: districts,
            urbans: urbans,
            realEstateTypes: realEstateTypes,
            searchText: searchText,
            currencyId: CurrencyScope.currency(context, listen: false).id,
            priceFrom: priceFrom,
            priceTo: priceTo,
            areaFrom: areaFrom,
            areaTo: areaTo,
            floorFrom: floorFrom,
            floorTo: floorTo,
            notFirstFloor: notFirstFloor,
            notLastFloor: notLastFloor,
            isLastFloor: isLastFloor,
            rooms: rooms,
          ));

  static void loadMore(BuildContext context) => context.read<SearchBloc>().add(SearchEvent.loadMore(
        LocalizationScope.getLocaleCode(context, listen: false),
      ));

  static List<SearchItem> items(BuildContext context) => context.watch<SearchBloc>().state.items;

  static bool isLoadingMore(BuildContext context) => context.watch<SearchBloc>().state.isLoadingMore;
  @override
  Widget build(BuildContext context) => BlocProvider<SearchBloc>(
        create: (context) => getIt<SearchBloc>()
          ..add(SearchEvent.search(
            locale: LocalizationScope.getLocaleCode(context, listen: false),
          )),
        child: child,
        lazy: false,
      );
}
