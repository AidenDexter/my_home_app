import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../data_source/localization_control_local_db.dart';

@immutable
abstract interface class ILocalizationControlRepository {
  Future<String> getLocale();
  Future<void> saveLocale(String locale);
  String get lastInitedLocale;
}

@immutable
@LazySingleton(as: ILocalizationControlRepository)
class LocalizationControlRepository implements ILocalizationControlRepository {
  final ILocalizationControlLocalDB _datasource;

  const LocalizationControlRepository({required ILocalizationControlLocalDB datasource}) : _datasource = datasource;

  @override
  Future<String> getLocale() {
    return _datasource.getLocale();
  }

  @override
  Future<void> saveLocale(String locale) => _datasource.saveLocale(locale);

  @override
  String get lastInitedLocale => _datasource.lastInitedLocale;
}
