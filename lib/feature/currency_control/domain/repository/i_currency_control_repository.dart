import 'package:flutter/foundation.dart' show immutable;

import '../entity/currency.dart';

@immutable
abstract interface class ICurrencyControlRepository {
  Future<Currency> getCurrency();
  Future<void> saveCurrency(Currency currency);
  Currency get lastUsedCurrency;
}
