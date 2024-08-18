part of '../app_router.dart';

final _homeRoutes = [
  GoRoute(
    path: HomeRoutes.home.path,
    builder: (_, state) => ChooseAreaPage(key: state.pageKey),
  ),
  GoRoute(
    path: HomeRoutes.notifications.path,
    builder: (_, state) => Placeholder(key: state.pageKey),
  ),
];
