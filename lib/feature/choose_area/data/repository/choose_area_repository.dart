import 'package:flutter/foundation.dart' show immutable;
import 'package:injectable/injectable.dart';

import '../../domain/entity/choose_area_response.dart';
import '../../domain/repository/i_choose_area_repository.dart';
import '../data_source/choose_area_remote_db.dart';

@immutable
@LazySingleton(as: IChooseAreaRepository)
class ChooseAreaRepository implements IChooseAreaRepository {
  final ChooseAreaRemoteDB _remoteDB;
  const ChooseAreaRepository({required ChooseAreaRemoteDB remoteDB}) : _remoteDB = remoteDB;

  @override
  Future<ChooseAreaResponse> fetchCities() => _remoteDB.fetchCities();
}
