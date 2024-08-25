import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
enum LocaleEntity {
  ka(countryCode: 'Ka', languageCode: 'ka', titleName: 'ქართული'),
  ru(countryCode: 'Ru', languageCode: 'ru', titleName: 'Русский'),
  en(countryCode: 'En', languageCode: 'en', titleName: 'English');

  final String languageCode;
  final String countryCode;
  final String titleName;

  const LocaleEntity({
    required this.languageCode,
    required this.countryCode,
    required this.titleName,
  });

  factory LocaleEntity.fromLocale(Locale locale) {
    return LocaleEntity.values.firstWhere(
      (element) => element.languageCode == locale.languageCode,
      orElse: () => LocaleEntity.ka,
    );
  }

  factory LocaleEntity.fromLanguageCode(String? languageCode) {
    return LocaleEntity.values.firstWhere(
      (element) => element.languageCode == languageCode,
      orElse: () => LocaleEntity.ka,
    );
  }

  Locale get toLocale => Locale(languageCode, countryCode);
}
