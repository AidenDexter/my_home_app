import 'package:flutter/foundation.dart' show immutable;
import 'package:injectable/injectable.dart';

import '../../../search/domain/entity/search_response.dart';
import '../../domain/repository/i_home_repository.dart';
import '../data_source/home_remote_db.dart';

@immutable
@LazySingleton(as: IHomeRepository)
class HomeRepository implements IHomeRepository {
  final HomeRemoteDB _remoteDB;
  const HomeRepository({required HomeRemoteDB remoteDB}) : _remoteDB = remoteDB;

  @override
  Future<List<SearchItem>> fetchSuperVipItems(String locale) async {
    return (await _remoteDB.fetchSuperVipItems(locale)).data.data;
  }

  @override
  Future<List<SearchItem>> fetchVipPlusItems(String locale) async {
    return (await _remoteDB.fetchVipPlusItems(locale)).data.data;
  }
}
