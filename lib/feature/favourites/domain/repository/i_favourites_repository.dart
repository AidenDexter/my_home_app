import 'package:flutter/foundation.dart' show immutable;

import '../../../search/domain/entity/search_response.dart';

@immutable
abstract interface class IFavouritesRepository {
  Future<void> saveFavourites({required List<String> value});
  List<String> get lastSavedFavourites;
  Future<SearchResponse> fetchFavouriteInfo({required String id, required String locale});
}
