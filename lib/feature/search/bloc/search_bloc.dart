import 'package:bloc_concurrency/bloc_concurrency.dart';
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
      transformer: restartable(),
    );
  }

  int _page = 1;
  bool _isEndOfList = false;

  String _lastFilter = '';

  Future<void> _search(_SearchEvent event, Emitter<SearchState> emit) async {
    emit(SearchState.initProgress(state.items));
    try {
      _page = 1;
      _isEndOfList = false;
      final filter = '${event.cityId == null ? '' : '&cities=${event.cityId}'}'
          '${event.realEstateTypes.isEmpty ? '' : '&real_estate_types=${event.realEstateTypes.join(',')}'}'
          '${event.dealType == null ? '' : '&deal_types=${event.dealType}'}'
          '${event.districts.isEmpty ? '' : '&districts=${event.districts.join(',')}'}'
          '${event.urbans.isEmpty ? '' : '&urbans=${event.urbans.join(',')}'}'
          '${event.searchText.isEmpty ? '' : '&q=${event.searchText}'}'
          '${event.currencyId == null ? '' : '&currency_id=${event.currencyId}'}'
          '${event.priceFrom.isEmpty ? '' : '&price_from=${event.priceFrom}'}'
          '${event.priceTo.isEmpty ? '' : '&price_to=${event.priceTo}'}'
          '${event.areaFrom.isEmpty ? '' : '&area_from=${event.areaFrom}'}'
          '${event.areaTo.isEmpty ? '' : '&area_to=${event.areaTo}'}'
          '${event.floorFrom.isEmpty ? '' : '&floor_from=${event.floorFrom}'}'
          '${event.floorTo.isEmpty ? '' : '&floor_to=${event.floorTo}'}'
          '${!event.notFirstFloor ? '' : '&not_first=${event.notFirstFloor}'}'
          '${!event.notLastFloor ? '' : '&not_last=${event.notLastFloor}'}'
          '${!event.isLastFloor ? '' : '&is_last=${event.isLastFloor}'}';

      _lastFilter = filter;
      final items = await _repository.search('page=$_page$_lastFilter');
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
      final transactions = await _repository.search('page=$_page$_lastFilter');
      emit(SearchState.idle([...state.items, ...transactions]));
      _page++;
      if (transactions.length < 20) _isEndOfList = true;
    } on Object catch (error) {
      emit(SearchState.error(errorHandler: error.toHandler, items: state.items));
    }
  }
}
