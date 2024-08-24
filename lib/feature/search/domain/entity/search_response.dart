import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:l/l.dart';

part 'search_response.g.dart';

@immutable
@JsonSerializable(createToJson: false)
class SearchResponse {
  final bool result;
  final Data data;

  const SearchResponse({required this.result, required this.data});

  factory SearchResponse.fromJson(Map<String, dynamic> json) => _$SearchResponseFromJson(json);
}

@immutable
class Data {
  final List<SearchItem> data;

  const Data({required this.data});

  factory Data.fromJson(Map<String, dynamic> json) {
    final res = <SearchItem>[];

    for (final item in json['data'] as List<dynamic>) {
      try {
        res.add(SearchItem.fromJson(item as Map<String, dynamic>));
      } on Object catch (e) {
        l.w(e);
      }
    }
    return Data(data: res);
  }
}

@immutable
@JsonSerializable(createToJson: false)
class SearchItem {
  final int id;
  @JsonKey(name: 'deal_type_id')
  final int? dealTypeId;
  @JsonKey(name: 'real_estate_type_id')
  final int? realEstateTypeId;
  @JsonKey(name: 'status_id')
  final int? statusId;
  final String uuid;
  final Price price;
  @JsonKey(name: 'price_negotiable')
  final bool priceNegotiable;
  @JsonKey(name: 'price_from')
  final bool priceFrom;
  final double? lat;
  final double? lng;
  final List<Images> images;
  final String? address;
  final double? area;
  @JsonKey(name: 'yard_area')
  final dynamic yardArea;
  @JsonKey(name: 'area_type_id')
  final int? areaTypeId;
  final String? bedroom;
  final String? room;
  final List<dynamic>? gifts;
  final bool favorite;
  @JsonKey(name: 'is_old')
  final bool isOld;
  @JsonKey(name: 'dynamic_title')
  final String? dynamicTitle;
  @JsonKey(name: 'dynamic_slug')
  final String? dynamicSlug;
  @JsonKey(name: 'last_updated')
  final DateTime lastUpdated;
  final int? floor;
  @JsonKey(name: 'total_floors')
  final int? totalFloors;
  @JsonKey(name: 'street_id')
  final int? streetId;
  @JsonKey(name: 'urban_id')
  final int? urbanId;
  @JsonKey(name: 'urban_name')
  final String? urbanName;
  @JsonKey(name: 'district_id')
  final int? districtId;
  @JsonKey(name: 'district_name')
  final String? districtName;
  @JsonKey(name: 'city_name')
  final String? cityName;
  @JsonKey(name: 'quantity_of_day')
  final int? quantityOfDay;
  final bool hidden;
  final bool viewed;
  @JsonKey(name: 'user_id')
  final int? userId;
  @JsonKey(name: 'price_type_id')
  final int? priceTypeId;
  @JsonKey(name: 'statement_currency_id')
  final int? statementCurrencyId;
  @JsonKey(name: 'currency_id')
  final int? currencyId;
  @JsonKey(name: 'user_title')
  final String? userTitle;
  @JsonKey(name: 'grouped_street_id')
  final int? groupedStreetId;
  final List<Parameters>? parameters;
  final String? comment;
  @JsonKey(name: 'has_color')
  final bool hasColor;
  @JsonKey(name: 'is_vip')
  final bool isVip;
  @JsonKey(name: 'is_vip_plus')
  final bool isVipPlus;
  @JsonKey(name: 'is_super_vip')
  final bool isSuperVip;
  @JsonKey(name: 'user_statements_count')
  final dynamic userStatementsCount;
  @JsonKey(name: 'user_type')
  final UserType? userType;

  const SearchItem({
    required this.id,
    required this.dealTypeId,
    required this.realEstateTypeId,
    required this.statusId,
    required this.uuid,
    required this.price,
    required this.priceNegotiable,
    required this.priceFrom,
    required this.lat,
    required this.lng,
    required this.images,
    required this.address,
    required this.area,
    required this.yardArea,
    required this.areaTypeId,
    required this.bedroom,
    required this.room,
    required this.gifts,
    required this.favorite,
    required this.isOld,
    required this.dynamicTitle,
    required this.dynamicSlug,
    required this.lastUpdated,
    required this.floor,
    required this.totalFloors,
    required this.streetId,
    required this.urbanId,
    required this.urbanName,
    required this.districtId,
    required this.districtName,
    required this.cityName,
    required this.quantityOfDay,
    required this.hidden,
    required this.viewed,
    required this.userId,
    required this.priceTypeId,
    required this.statementCurrencyId,
    required this.currencyId,
    required this.userTitle,
    required this.groupedStreetId,
    required this.parameters,
    required this.comment,
    required this.hasColor,
    required this.isVip,
    required this.isVipPlus,
    required this.isSuperVip,
    required this.userStatementsCount,
    required this.userType,
  });

  factory SearchItem.fromJson(Map<String, dynamic> json) => _$SearchItemFromJson(json);
}

@immutable
@JsonSerializable(createToJson: false)
class Price {
  /// Цена в ларах
  @JsonKey(name: '1')
  final PriceItem first;

  /// Цена в долларах
  @JsonKey(name: '2')
  final PriceItem second;

  @JsonKey(name: '3')
  final PriceItem third;

  const Price({required this.first, required this.second, required this.third});

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);
}

@immutable
@JsonSerializable(createToJson: false)
class PriceItem {
  @JsonKey(name: 'price_total')
  final int priceTotal;
  @JsonKey(name: 'price_square')
  final int priceSquare;

  const PriceItem({required this.priceTotal, required this.priceSquare});

  factory PriceItem.fromJson(Map<String, dynamic> json) => _$PriceItemFromJson(json);
}

@immutable
@JsonSerializable(createToJson: false)
class Images {
  final String large;
  final String thumb;
  @JsonKey(name: 'large_webp')
  final String? largeWebp;
  @JsonKey(name: 'thumb_webp')
  final String? thumbWebp;

  const Images({required this.large, required this.thumb, this.largeWebp, this.thumbWebp});

  factory Images.fromJson(Map<String, dynamic> json) => _$ImagesFromJson(json);
}

@immutable
@JsonSerializable(createToJson: false)
class Parameters {
  final int? id;
  final String? key;
  @JsonKey(name: 'sort_index')
  final int? sortIndex;
  @JsonKey(name: 'deal_type_id')
  final dynamic dealTypeId;
  @JsonKey(name: 'input_name')
  final String? inputName;
  @JsonKey(name: 'select_name')
  final String? selectName;
  @JsonKey(name: 'svg_file_name')
  final String? svgFileName;
  @JsonKey(name: 'background_color')
  final String? backgroundColor;
  final String? type;
  @JsonKey(name: 'display_name')
  final String? displayName;
  @JsonKey(name: 'parameter_value')
  final dynamic parameterValue;
  @JsonKey(name: 'parameter_select_name')
  final dynamic parameterSelectName;

  const Parameters(
      {this.id,
      this.key,
      this.sortIndex,
      this.dealTypeId,
      this.inputName,
      this.selectName,
      this.svgFileName,
      this.backgroundColor,
      this.type,
      this.displayName,
      this.parameterValue,
      this.parameterSelectName});

  factory Parameters.fromJson(Map<String, dynamic> json) => _$ParametersFromJson(json);
}

@immutable
@JsonSerializable(createToJson: false)
class UserType {
  final String? type;

  const UserType({this.type});

  factory UserType.fromJson(Map<String, dynamic> json) => _$UserTypeFromJson(json);
}
