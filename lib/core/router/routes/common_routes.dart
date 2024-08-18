part of '../app_router.dart';

final _commonRoutes = [
  GoRoute(
    path: CommonRoutes.filters.path,
    builder: (_, state) => Placeholder(key: state.pageKey),
  ),
  GoRoute(
    path: CommonRoutes.contacts.path,
    builder: (_, state) => Placeholder(key: state.pageKey),
  ),
  GoRoute(
    path: CommonRoutes.help.path,
    builder: (_, state) => Placeholder(key: state.pageKey),
  ),
  GoRoute(
    path: CommonRoutes.settings.path,
    builder: (_, state) => Placeholder(key: state.pageKey),
  ),
  GoRoute(
    path: CommonRoutes.aboutApp.path,
    builder: (_, state) => Placeholder(key: state.pageKey),
  ),
];
