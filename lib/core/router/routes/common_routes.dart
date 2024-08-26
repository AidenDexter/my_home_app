part of '../app_router.dart';

final _commonRoutes = [
  GoRoute(
    path: CommonRoutes.filters.path,
    builder: (_, state) {
      assert(state.extra is Map<String, Object>);
      assert((state.extra! as Map<String, Object>)['search'] is VoidCallback);
      assert((state.extra! as Map<String, Object>)['dealType'] is ValueNotifier<DealType?>);
      assert((state.extra! as Map<String, Object>)['realEstateTypes'] is ValueNotifier<List<RealEstateType>>);
      assert((state.extra! as Map<String, Object>)['priceFrom'] is TextEditingController);
      assert((state.extra! as Map<String, Object>)['priceTo'] is TextEditingController);
      assert((state.extra! as Map<String, Object>)['areaFrom'] is TextEditingController);
      assert((state.extra! as Map<String, Object>)['areaTo'] is TextEditingController);
      assert((state.extra! as Map<String, Object>)['floorFrom'] is TextEditingController);
      assert((state.extra! as Map<String, Object>)['floorTo'] is TextEditingController);

      assert((state.extra! as Map<String, Object>)['notFirstFloor'] is ValueNotifier<bool>);
      assert((state.extra! as Map<String, Object>)['notLastFloor'] is ValueNotifier<bool>);
      assert((state.extra! as Map<String, Object>)['isLastFloor'] is ValueNotifier<bool>);

      return FiltersPage(
        key: state.pageKey,
        dealType: (state.extra! as Map<String, Object>)['dealType']! as ValueNotifier<DealType?>,
        realEstateTypes:
            (state.extra! as Map<String, Object>)['realEstateTypes']! as ValueNotifier<List<RealEstateType>>,
        priceFromController: (state.extra! as Map<String, Object>)['priceFrom']! as TextEditingController,
        priceToController: (state.extra! as Map<String, Object>)['priceTo']! as TextEditingController,
        areaFromController: (state.extra! as Map<String, Object>)['areaFrom']! as TextEditingController,
        areaToController: (state.extra! as Map<String, Object>)['areaTo']! as TextEditingController,
        search: (state.extra! as Map<String, Object>)['search']! as VoidCallback,
        floorFromController: (state.extra! as Map<String, Object>)['floorFrom']! as TextEditingController,
        floorToController: (state.extra! as Map<String, Object>)['floorTo']! as TextEditingController,
        notFirstFloorController: (state.extra! as Map<String, Object>)['notFirstFloor']! as ValueNotifier<bool>,
        notLastFloorController: (state.extra! as Map<String, Object>)['notLastFloor']! as ValueNotifier<bool>,
        isLastFloorController: (state.extra! as Map<String, Object>)['isLastFloor']! as ValueNotifier<bool>,
      );
    },
  ),
  GoRoute(
    path: CommonRoutes.chooseArea.path,
    builder: (_, state) {
      assert(state.extra is Map<String, Object>);
      assert((state.extra! as Map<String, Object>)['city'] is ValueNotifier<int?>);
      assert((state.extra! as Map<String, Object>)['districts'] is ValueNotifier<List<int>>);
      assert((state.extra! as Map<String, Object>)['urbans'] is ValueNotifier<List<int>>);
      assert((state.extra! as Map<String, Object>)['search'] is VoidCallback);

      return ChooseAreaPage(
        key: state.pageKey,
        selectedCity: (state.extra! as Map<String, Object>)['city']! as ValueNotifier<int?>,
        selectedDistricts: (state.extra! as Map<String, Object>)['districts']! as ValueNotifier<List<int>>,
        selectedUrbans: (state.extra! as Map<String, Object>)['urbans']! as ValueNotifier<List<int>>,
        search: (state.extra! as Map<String, Object>)['search']! as VoidCallback,
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
