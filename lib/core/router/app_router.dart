import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import '../../feature/ad_details/presentation/ad_details_page.dart';
import '../../feature/choose_area/presentation/choose_area_page.dart';
import '../../feature/home/presentation/home_page.dart';
import '../../feature/mock/presentation/mock_page.dart';
import '../../feature/root/presentation/root_page.dart';
import '../../feature/search/domain/entity/deal_type.dart';
import '../../feature/search/domain/entity/real_estate_type.dart';
import '../../feature/search/domain/entity/search_response.dart';
import '../../feature/search/presentation/filters/filters_page.dart';
import '../../feature/search/presentation/search_page.dart';
import 'routes_enum.dart';

part 'routes/home_routes.dart';
part 'routes/search_routes.dart';
part 'routes/add_ad_routes.dart';
part 'routes/ad_details_routes.dart';
part 'routes/favourites_routes.dart';
part 'routes/profile_routes.dart';
part 'routes/common_routes.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'RootNavigatorKey');
final _homeRoutesNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'HomeRoutesNavigatorKey');
final _searchRoutesNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'SearchRoutesNavigatorKey');
final _favouritesRoutesNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'FavouritesRoutesNavigatorKey');
final _profileRoutesNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'ProfileRoutesNavigatorKey');

@singleton
class AppRouter {
  // final IInitialRouteService _initialRouteService;

  AppRouter();

  GoRouter get router => GoRouter(
        navigatorKey: rootNavigatorKey,
        debugLogDiagnostics: kDebugMode,
        initialLocation: HomeRoutes.home.path,
        routes: [
          ..._commonRoutes,
          ..._addAdRoutes,
          _commonBottomNavigationBarShellRoute,
        ],
        errorBuilder: (_, state) => Placeholder(key: state.pageKey),
      );
}

final _commonBottomNavigationBarShellRoute = StatefulShellRoute.indexedStack(
  branches: [
    _homeRoutesBranch,
    _searchRoutesBranch,
    _favouritesRoutesBranch,
    _profileRoutesBranch,
  ],
  builder: (_, state, navigationShell) => RootPage(
    key: state.pageKey,
    navigationShell: navigationShell,
  ),
);

final _homeRoutesBranch = StatefulShellBranch(
  navigatorKey: _homeRoutesNavigatorKey,
  initialLocation: HomeRoutes.home.path,
  routes: [
    ..._homeRoutes,
    ..._adDetailsRoutes,
  ],
);

final _searchRoutesBranch = StatefulShellBranch(
  navigatorKey: _searchRoutesNavigatorKey,
  initialLocation: SearchRoutes.search.path,
  routes: [
    ..._searchRoutes,
    ..._adDetailsRoutes,
  ],
);

final _favouritesRoutesBranch = StatefulShellBranch(
  navigatorKey: _favouritesRoutesNavigatorKey,
  initialLocation: FavouritesRoutes.favourites.path,
  routes: [
    ..._favouritesRoutes,
    ..._adDetailsRoutes,
  ],
);

final _profileRoutesBranch = StatefulShellBranch(
  navigatorKey: _profileRoutesNavigatorKey,
  initialLocation: ProfileRoutes.profile.path,
  routes: [
    ..._profileRoutes,
  ],
);
