part of 'favourites_bloc.dart';

@freezed
class FavouritesState with _$FavouritesState {
  const FavouritesState._();

  const factory FavouritesState.idle({required List<int> favourites}) = _IdleFavouritesState;
}
