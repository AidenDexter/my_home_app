import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/error/error_handler.dart';
import '../domain/entity/search_response.dart';
import '../domain/repository/i_search_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

part 'search_bloc.freezed.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ISearchRepository _repository;

  SearchBloc({required ISearchRepository repository})
      : _repository = repository,
        super(const SearchState.initProgress([])) {
    on<SearchEvent>(
      (event, emit) => event.map(
        search: (event) => _search(event, emit),
        loadMore: (event) => _loadMore(event, emit),
      ),
    );
  }

  int _page = 1;
  bool _isEndOfList = false;

  Future<void> _search(_SearchEvent event, Emitter<SearchState> emit) async {
    emit(SearchState.initProgress(state.items));
    try {
      _page = 1;
      _isEndOfList = false;
      final items = await _repository.search(_page);
      emit(SearchState.idle(items));
      _page++;
    } on Object catch (error) {
      emit(SearchState.error(errorHandler: error.toHandler, items: state.items));
    }
  }

  Future<void> _loadMore(_LoadMoreEvent event, Emitter<SearchState> emit) async {
    if (_isEndOfList) return;
    emit(SearchState.loadMoreProgress(state.items));
    try {
      final transactions = await _repository.search(_page);
      emit(SearchState.idle([...state.items, ...transactions]));
      _page++;
      if (transactions.length < 20) _isEndOfList = true;
    } on Object catch (error) {
      emit(SearchState.error(errorHandler: error.toHandler, items: state.items));
    }
  }
}
