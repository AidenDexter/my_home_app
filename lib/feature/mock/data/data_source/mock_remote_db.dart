
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../domain/entity/post.dart';

part 'mock_remote_db.g.dart';

@RestApi()
@injectable
abstract class MockRemoteDB {
  @factoryMethod
  factory MockRemoteDB(@Named('BaseDio') Dio dio) = _MockRemoteDB;

  @GET('/posts/{id}')
  Future<Post> getPost(@Path() int id);
}
