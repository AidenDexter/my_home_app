part of 'search_bloc.dart';

@freezed
class SearchEvent with _$SearchEvent {
  const factory SearchEvent.search() = _SearchEvent;
  const factory SearchEvent.loadMore() = _LoadMoreEvent;
}
