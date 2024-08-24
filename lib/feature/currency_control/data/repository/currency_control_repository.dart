import 'package:flutter/foundation.dart' show immutable;
import 'package:injectable/injectable.dart';

import '../../domain/entity/currency.dart';
import '../../domain/repository/i_currency_control_repository.dart';
import '../data_source/currency_control_datasource.dart';

@immutable
@Singleton(as: ICurrencyControlRepository)
class CurrencyControlRepository implements ICurrencyControlRepository {
  final ICurrencyControlDatasource _datasource;

  const CurrencyControlRepository({required ICurrencyControlDatasource datasource}) : _datasource = datasource;

  @override
  Future<Currency> getCurrency() => _datasource.getCurrency();

  @override
  Future<void> saveCurrency(Currency currency) => _datasource.saveCurrency(currency);

  @override
  Currency get lastUsedCurrency => _datasource.lastUsedCurrency;
}
