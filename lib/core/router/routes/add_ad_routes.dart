part of '../app_router.dart';

final _addAdRoutes = [
  GoRoute(
    path: AddAdRoutes.ad.path,
    builder: (_, state) => AddAdPage(key: state.pageKey),
  ),
];
