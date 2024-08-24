import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entity/currency.dart';

const _currency = 'currency';

abstract interface class ICurrencyControlDatasource {
  Future<Currency> getCurrency();
  Future<void> saveCurrency(Currency currency);
  Currency get lastUsedCurrency;
}

@LazySingleton(as: ICurrencyControlDatasource)
class CurrencyControlDatasource implements ICurrencyControlDatasource {
  final SharedPreferences _storage;
  final Currency _lastUsedCurrency;

  CurrencyControlDatasource._(this._storage, this._lastUsedCurrency);

  @FactoryMethod(preResolve: true)
  static Future<CurrencyControlDatasource> init({required SharedPreferences sharedPrefsStorage}) async {
    final currency = await _getCurrency(sharedPrefsStorage);
    return CurrencyControlDatasource._(sharedPrefsStorage, currency);
  }

  static Future<Currency> _getCurrency(SharedPreferences storage) async {
    if (!storage.containsKey(_currency)) return Currency.lari;

    final savedValue = storage.getString(_currency);

    if (savedValue == 'dollar') return Currency.dollar;
    return Currency.lari;
  }

  @override
  Future<Currency> getCurrency() {
    return _getCurrency(_storage);
  }

  @override
  Future<void> saveCurrency(Currency currency) => _storage.setString(_currency, currency.name);

  @override
  Currency get lastUsedCurrency => _lastUsedCurrency;
}
