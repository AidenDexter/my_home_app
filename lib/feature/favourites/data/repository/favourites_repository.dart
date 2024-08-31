import 'package:flutter/foundation.dart' show immutable;
import 'package:injectable/injectable.dart';

import '../../domain/repository/i_favourites_repository.dart';
import '../data_source/favourites_local_db.dart';
import '../data_source/favourites_remote_db.dart';

@immutable
@LazySingleton(as: IFavouritesRepository)
class FavouritesRepository implements IFavouritesRepository {
  final FavouritesRemoteDB _remoteDB;
  final IFavouritesLocalDB _localDB;
  const FavouritesRepository({
    required FavouritesRemoteDB remoteDB,
    required IFavouritesLocalDB localDB,
  })  : _remoteDB = remoteDB,
        _localDB = localDB;

  @override
  List<String> get lastSavedFavourites => _localDB.lastSavedFavourites;

  @override
  Future<void> saveFavourites({required List<String> value}) => _localDB.saveFavourites(value: value);
}
