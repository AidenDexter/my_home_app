part of '../app_router.dart';

final _addAdRoutes = [
  GoRoute(
    path: AddAdRoutes.ad.path,
    builder: (_, state) => Placeholder(key: state.pageKey),
  ),
];
