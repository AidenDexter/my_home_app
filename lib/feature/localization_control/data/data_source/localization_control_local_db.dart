import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _locale = 'locale';

abstract interface class ILocalizationControlLocalDB {
  Future<String> getLocale();
  Future<void> saveLocale(String locale);
  String get lastInitedLocale;
}

@LazySingleton(as: ILocalizationControlLocalDB)
class LocalizationControlLocalDB implements ILocalizationControlLocalDB {
  final SharedPreferences _storage;
  final String _lastInitedLocale;

  LocalizationControlLocalDB._(this._storage, this._lastInitedLocale);

  @FactoryMethod(preResolve: true)
  static Future<LocalizationControlLocalDB> init({required SharedPreferences sharedPrefsStorage}) async {
    final locale = await _getLocale(sharedPrefsStorage);
    return LocalizationControlLocalDB._(sharedPrefsStorage, locale);
  }

  static Future<String> _getLocale(SharedPreferences storage) async {
    if (!storage.containsKey(_locale)) return 'ka';
    return storage.getString(_locale) ?? 'ka';
  }

  @override
  Future<String> getLocale() {
    return _getLocale(_storage);
  }

  @override
  Future<void> saveLocale(String locale) => _storage.setString(_locale, locale);

  @override
  String get lastInitedLocale => _lastInitedLocale;
}
