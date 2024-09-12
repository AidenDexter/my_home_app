part of 'favourites_bloc.dart';

@freezed
class FavouritesState with _$FavouritesState {
  const FavouritesState._();

  const factory FavouritesState.idle({required List<FavouriteEntity> favourites}) = _IdleFavouritesState;
}
