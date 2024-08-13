import 'package:flutter/foundation.dart' show immutable;
import 'package:injectable/injectable.dart';

import '../../domain/entity/post.dart';
import '../../domain/repository/i_mock_repository.dart';
import '../data_source/mock_remote_db.dart';

@immutable
@LazySingleton(as: IMockRepository)
class MockRepository implements IMockRepository {
  final MockRemoteDB _remoteDB;
  const MockRepository({required MockRemoteDB remoteDB}) : _remoteDB = remoteDB;

  @override
  Future<Post> getPost(int id) => _remoteDB.getPost(id);
}
