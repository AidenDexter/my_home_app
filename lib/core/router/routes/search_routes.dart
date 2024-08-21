part of '../app_router.dart';

final _searchRoutes = [
  GoRoute(
    path: SearchRoutes.search.path,
    builder: (_, state) => SearchPage(key: state.pageKey),
  ),
];
