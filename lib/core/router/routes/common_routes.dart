part of '../app_router.dart';

final _commonRoutes = [
  GoRoute(
    path: CommonRoutes.filters.path,
    builder: (_, state) => Placeholder(key: state.pageKey),
  ),
  GoRoute(
    path: CommonRoutes.chooseArea.path,
    builder: (_, state) {
      assert(state.extra is Map<String, Object>);
      assert((state.extra! as Map<String, Object>)['city'] is ValueNotifier<int?>);
      assert((state.extra! as Map<String, Object>)['disctricts'] is ValueNotifier<List<int>>);
      assert((state.extra! as Map<String, Object>)['urbans'] is ValueNotifier<List<int>>);

      return ChooseAreaPage(
        key: state.pageKey,
        selectedCity: (state.extra! as Map<String, Object>)['city']! as ValueNotifier<int?>,
        selectedDisctricts: (state.extra! as Map<String, Object>)['disctricts']! as ValueNotifier<List<int>>,
        selectedUrbans: (state.extra! as Map<String, Object>)['urbans']! as ValueNotifier<List<int>>,
      );
    },
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
