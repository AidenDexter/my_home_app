import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/repository/i_favourites_repository.dart';

part 'favourites_bloc.freezed.dart';
part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  final IFavouritesRepository _repository;

  FavouritesBloc({required IFavouritesRepository repository})
      : _repository = repository,
        super(FavouritesState.idle(favourites: repository.lastSavedFavourites.map(int.parse).toList())) {
    on<FavouritesEvent>(
      (event, emit) => event.map(
        add: (event) => _add(event, emit),
        remove: (event) => _remove(event, emit),
      ),
    );
  }

  void _add(_AddFavouritesEvent event, Emitter<FavouritesState> emit) {
    if (state.favourites.contains(event.id)) return;
    emit(FavouritesState.idle(favourites: [...state.favourites, event.id]));
    _repository.saveFavourites(value: state.favourites.map((e) => e.toString()).toList());
  }

  void _remove(_RemoveFavouritesEvent event, Emitter<FavouritesState> emit) {
    if (!state.favourites.contains(event.id)) return;
    emit(FavouritesState.idle(favourites: List.from(state.favourites)..remove(event.id)));
    _repository.saveFavourites(value: state.favourites.map((e) => e.toString()).toList());
  }
}
