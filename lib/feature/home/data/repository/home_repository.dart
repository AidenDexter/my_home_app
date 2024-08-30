import 'package:flutter/foundation.dart' show immutable;
import 'package:injectable/injectable.dart';

import '../../domain/entity/home_response.dart';
import '../../domain/repository/i_home_repository.dart';
import '../data_source/mock_remote_db.dart';

@immutable
@LazySingleton(as: IHomeRepository)
class HomeRepository implements IHomeRepository {
  final HomeRemoteDB _remoteDB;
  const HomeRepository({required HomeRemoteDB remoteDB}) : _remoteDB = remoteDB;

  @override
  Future<HomeResponse> fetchHome() => _remoteDB.fetchHome();
}
