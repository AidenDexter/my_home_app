import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract interface class IFavouritesRepository {
  Future<void> saveFavourites({required List<String> value});
  List<String> get lastSavedFavourites;
}
