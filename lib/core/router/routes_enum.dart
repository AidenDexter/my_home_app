const _homeRoutesKey = '/home_routes/';
const _searchRoutesKey = '/search_routes/';
const _addAdRoutesKey = '/add_ad_routes/';
const _adDetailsRoutesKey = '/ad_details_routes/';
const _favouritesRoutesKey = '/favourites_routes/';
const _profileRoutesKey = '/profile_routes/';
const _commonRoutesKey = '/common_routes/';

enum HomeRoutes {
  home(path: '${_homeRoutesKey}home'),
  notifications(path: '${_homeRoutesKey}notifications');

  final String path;

  const HomeRoutes({
    required this.path,
  });
}

enum SearchRoutes {
  search(path: '${_searchRoutesKey}search'),
  filters(path: '${_homeRoutesKey}filters');

  final String path;

  const SearchRoutes({
    required this.path,
  });
}

enum AddAdRoutes {
  ad(path: '${_addAdRoutesKey}ad');

  final String path;

  const AddAdRoutes({
    required this.path,
  });
}

enum FavouritesRoutes {
  favourites(path: '${_favouritesRoutesKey}favourites');

  final String path;

  const FavouritesRoutes({
    required this.path,
  });
}

enum ProfileRoutes {
  profile(path: '${_profileRoutesKey}profile');

  final String path;

  const ProfileRoutes({
    required this.path,
  });
}

enum AdDetailsRoutes {
  details(path: '${_adDetailsRoutesKey}details');

  final String path;

  const AdDetailsRoutes({
    required this.path,
  });
}

enum CommonRoutes {
  filters(path: '${_commonRoutesKey}filters'),
  contacts(path: '${_commonRoutesKey}contacts'),
  help(path: '${_commonRoutesKey}help'),
  settings(path: '${_commonRoutesKey}settings'),
  aboutApp(path: '${_commonRoutesKey}about_app');

  final String path;

  const CommonRoutes({
    required this.path,
  });
}
