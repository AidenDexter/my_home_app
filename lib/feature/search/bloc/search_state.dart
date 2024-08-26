part of 'search_bloc.dart';

@freezed
class SearchState with _$SearchState {
  const SearchState._();

  bool get isLoadingMore => this is _LoadMoreProgressState;

  const factory SearchState.initProgress(List<SearchItem> items) = _InitProgressSearchState;

  const factory SearchState.idle(List<SearchItem> items) = _IdleSearchState;

  const factory SearchState.loadMoreProgress(List<SearchItem> items) = _LoadMoreProgressState;

  const factory SearchState.error({
    required IErrorHandler errorHandler,
    required List<SearchItem> items,
  }) = _ErrorSearchState;
}
