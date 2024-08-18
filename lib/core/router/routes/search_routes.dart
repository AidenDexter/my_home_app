part of '../app_router.dart';

final _searchRoutes = [
  GoRoute(
    path: SearchRoutes.search.path,
    builder: (_, state) => Placeholder(key: state.pageKey),
  ),
  GoRoute(
    path: SearchRoutes.filters.path,
    builder: (_, state) => Placeholder(key: state.pageKey),
  ),
];
