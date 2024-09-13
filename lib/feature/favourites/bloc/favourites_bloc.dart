import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../search/domain/entity/search_response.dart';
import '../domain/entity/favourite_entity.dart';
import '../domain/repository/i_favourites_repository.dart';

part 'favourites_bloc.freezed.dart';
part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  final IFavouritesRepository _repository;

  FavouritesBloc({required IFavouritesRepository repository})
      : _repository = repository,
        super(
          FavouritesState.idle(
            favourites: repository.lastSavedFavourites.map(FavouriteEntity.fromString).toList(),
          ),
        ) {
    on<FavouritesEvent>(
      (event, emit) => event.map(
        add: (event) => _add(event, emit),
        remove: (event) => _remove(event, emit),
        fetchItem: (event) => _fetchItem(event, emit),
      ),
    );
  }

  void _add(_AddFavouritesEvent event, Emitter<FavouritesState> emit) {
    if (state.favourites.where((e) => e.id == event.item.id).isNotEmpty) return;
    emit(
      FavouritesState.idle(
        favourites: [
          FavouriteEntity(id: event.item.id, item: event.item),
          ...state.favourites,
        ],
      ),
    );
    _repository.saveFavourites(value: state.favourites.map((e) => e.id.toString()).toList());
  }

  void _remove(_RemoveFavouritesEvent event, Emitter<FavouritesState> emit) {
    if (state.favourites.where((e) => e.id == event.id).isEmpty) return;
    emit(FavouritesState.idle(favourites: List.from(state.favourites)..removeWhere((e) => e.id == event.id)));
    _repository.saveFavourites(value: state.favourites.map((e) => e.id.toString()).toList());
  }

  Future<void> _fetchItem(_FetchItemFavouritesEvent event, Emitter<FavouritesState> emit) async {
    if (state.favourites.firstWhere((e) => e.id == event.id).item != null) return;
    final index = state.favourites.indexWhere((e) => e.id == event.id);
    final item = state.favourites[index];
      emit(
        FavouritesState.idle(
          favourites: List.from(state.favourites)
            ..removeWhere((e) => e.id == event.id)
            ..insert(index, FavouriteEntity(id: item.id, item: item.item)),
        ),
      );
    try {
      final response = await _repository.fetchFavouriteInfo(id: event.id.toString(), locale: event.locale);
      final item = response.data.data[0];
      emit(
        FavouritesState.idle(
          favourites: List.from(state.favourites)
            ..removeWhere((e) => e.id == event.id)
            ..insert(index, FavouriteEntity(id: item.id, item: item, status: LoadingStatus.success)),
        ),
      );
    } on Object catch (_) {
      final item = state.favourites[index];
      emit(
        FavouritesState.idle(
          favourites: List.from(state.favourites)
            ..removeWhere((e) => e.id == event.id)
            ..insert(index, FavouriteEntity(id: item.id, item: item.item, status: LoadingStatus.error)),
        ),
      );
    }
  }
}
