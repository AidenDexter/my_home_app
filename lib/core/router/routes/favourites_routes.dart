part of '../app_router.dart';

final _favouritesRoutes = [
  GoRoute(
    path: FavouritesRoutes.favourites.path,
    builder: (_, state) => FavouritesPage(key: state.pageKey),
  ),
];
