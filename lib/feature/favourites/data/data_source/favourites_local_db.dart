import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _favourites = 'favourites';

abstract interface class IFavouritesLocalDB {
  Future<void> saveFavourites({required List<String> value});
  List<String> get lastSavedFavourites;
}

@Singleton(as: IFavouritesLocalDB)
class FavouritesControlDatasource implements IFavouritesLocalDB {
  final SharedPreferences _storage;
  final List<String> _lastSavedFavourites;
  const FavouritesControlDatasource._(this._storage, this._lastSavedFavourites);

  @FactoryMethod(preResolve: true)
  static Future<FavouritesControlDatasource> init({required SharedPreferences sharedPrefsStorage}) async {
    final lastSavedFavourites = await _loadFavourites(sharedPrefsStorage);
    return FavouritesControlDatasource._(sharedPrefsStorage, lastSavedFavourites);
  }

  static Future<List<String>> _loadFavourites(SharedPreferences storage) async {
    if (!storage.containsKey(_favourites)) return [];
    return storage.getStringList(_favourites)!;
  }

  @override
  Future<void> saveFavourites({required List<String> value}) => _storage.setStringList(_favourites, value);

  @override
  List<String> get lastSavedFavourites => _lastSavedFavourites;
}
