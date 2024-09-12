import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

import '../../../core/services/service_locator/service_locator.dart';
import '../../localization_control/presentation/localization_scope.dart';
import '../../search/domain/entity/search_response.dart';

import '../bloc/favourites_bloc.dart';
import '../domain/repository/i_favourites_repository.dart';

@immutable
class FavouritesScope extends SingleChildStatelessWidget {
  const FavouritesScope({super.key});

  static void add(BuildContext context, {required SearchItem item}) =>
      context.read<FavouritesBloc>().add(FavouritesEvent.add(item: item));

  static void remove(BuildContext context, {required int id}) =>
      context.read<FavouritesBloc>().add(FavouritesEvent.remove(id: id));

  static bool isFavourite(BuildContext context, {required int id, bool listen = true}) => listen
      ? context.watch<FavouritesBloc>().state.favourites.where((e) => e.id == id).isNotEmpty
      : context.read<FavouritesBloc>().state.favourites.where((e) => e.id == id).isNotEmpty;

  static void fetchItem(BuildContext context, {required int id}) => context
      .read<FavouritesBloc>()
      .add(FavouritesEvent.fetchItem(id: id, locale: LocalizationScope.getLocaleCode(context, listen: false)));

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => BlocProvider<FavouritesBloc>(
        create: (context) => FavouritesBloc(
          repository: getIt<IFavouritesRepository>(),
        ),
        child: child,
      );
}
