import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../localization_control/domain/locale_entity/locale_entity.dart';
import '../../../localization_control/presentation/localization_scope.dart';

part 'choose_area_response.g.dart';

@JsonSerializable(createToJson: false)
class ChooseAreaResponse {
  ChooseAreaResponse({
    required this.data,
    required this.success,
  });

  final List<Datum> data;
  final bool success;

  factory ChooseAreaResponse.fromJson(Map<String, dynamic> json) => _$ChooseAreaResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class Datum {
  Datum({
    required this.id,
    required this.lat,
    required this.lng,
    required this.districts,
    required this.translations,
    required this.urbans,
  });

  final int id;
  final double? lat;
  final double? lng;
  final List<Datum>? districts;
  final Translations translations;
  final List<Datum>? urbans;

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);
}

@JsonSerializable(createToJson: false)
class Translations {
  Translations({
    required this.en,
    required this.ka,
    required this.ru,
  });

  final Translate en;
  final Translate ka;
  final Translate ru;

  factory Translations.fromJson(Map<String, dynamic> json) => _$TranslationsFromJson(json);

  String getDisplayName(BuildContext context) {
    switch (LocalizationScope.localeEntity(context)) {
      case LocaleEntity.en:
        return en.displayName;
      case LocaleEntity.ru:
        return ru.displayName;
      case LocaleEntity.ka:
        return ka.displayName;
    }
  }
}

@JsonSerializable(createToJson: false)
class Translate {
  Translate({
    required this.displayName,
    required this.displayNameIn,
  });

  @JsonKey(name: 'display_name')
  final String displayName;

  @JsonKey(name: 'display_name_in')
  final String displayNameIn;

  factory Translate.fromJson(Map<String, dynamic> json) => _$TranslateFromJson(json);
}
