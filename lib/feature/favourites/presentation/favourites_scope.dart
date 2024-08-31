import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

import '../../../core/services/service_locator/service_locator.dart';
import '../bloc/favourites_bloc.dart';
import '../domain/repository/i_favourites_repository.dart';

@immutable
class FavouritesScope extends SingleChildStatelessWidget {
  const FavouritesScope({super.key});

  static void add(BuildContext context, {required int id}) =>
      context.read<FavouritesBloc>().add(FavouritesEvent.add(id: id));

  static void remove(BuildContext context, {required int id}) =>
      context.read<FavouritesBloc>().add(FavouritesEvent.remove(id: id));

  static bool isFavourite(BuildContext context, {required int id, bool listen = true}) => listen
      ? context.watch<FavouritesBloc>().state.favourites.contains(id)
      : context.read<FavouritesBloc>().state.favourites.contains(id);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => BlocProvider<FavouritesBloc>(
        create: (context) => FavouritesBloc(
          repository: getIt<IFavouritesRepository>(),
        ),
        child: child,
      );
}
