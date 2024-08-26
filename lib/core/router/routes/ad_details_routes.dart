part of '../app_router.dart';

final _adDetailsRoutes = [
  GoRoute(
    path: AdDetailsRoutes.details.path,
    builder: (_, state) {
      assert(state.extra is SearchItem);

      return AdDetailsPage(
        key: state.pageKey,
        item: state.extra! as SearchItem,
      );
    },
  ),
];
