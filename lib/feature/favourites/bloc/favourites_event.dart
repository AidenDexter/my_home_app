part of 'favourites_bloc.dart';

@freezed
class FavouritesEvent with _$FavouritesEvent {
  const factory FavouritesEvent.add({required int id}) = _AddFavouritesEvent;
  const factory FavouritesEvent.remove({required int id}) = _RemoveFavouritesEvent;
}
