part of 'search_bloc.dart';

@freezed
class SearchEvent with _$SearchEvent {
  const factory SearchEvent.search({
    int? cityId,
    int? dealType,
    @Default([]) List<int> realEstateTypes,
    @Default([]) List<int> districts,
    @Default([]) List<int> urbans,
    @Default('') String searchText,
    int? currencyId,
    @Default('') String priceFrom,
    @Default('') String priceTo,
    @Default('') String areaFrom,
    @Default('') String areaTo,
    @Default('') String floorFrom,
    @Default('') String floorTo,
    @Default(false) bool notFirstFloor,
    @Default(false) bool notLastFloor,
    @Default(false) bool isLastFloor,
  }) = _SearchEvent;

  const factory SearchEvent.loadMore() = _LoadMoreEvent;
}
