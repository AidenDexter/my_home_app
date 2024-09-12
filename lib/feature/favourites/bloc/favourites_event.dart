part of 'favourites_bloc.dart';

@freezed
class FavouritesEvent with _$FavouritesEvent {
  const factory FavouritesEvent.add({required SearchItem item}) = _AddFavouritesEvent;

  const factory FavouritesEvent.remove({required int id}) = _RemoveFavouritesEvent;

  const factory FavouritesEvent.fetchItem({required int id, required String locale}) = _FetchItemFavouritesEvent;
}
