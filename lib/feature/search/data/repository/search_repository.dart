import 'package:flutter/foundation.dart' show immutable;
import 'package:injectable/injectable.dart';

import '../../domain/entity/search_response.dart';
import '../../domain/repository/i_search_repository.dart';
import '../data_source/search_remote_db.dart';

@immutable
@LazySingleton(as: ISearchRepository)
class SearchRepository implements ISearchRepository {
  final SearchRemoteDB _remoteDB;
  const SearchRepository({required SearchRemoteDB remoteDB}) : _remoteDB = remoteDB;

  @override
  Future<List<SearchItem>> search(int page) async {
    return (await _remoteDB.search(page)).data.data;
  }
}
