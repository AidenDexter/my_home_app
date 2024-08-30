
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../domain/entity/home_response.dart';

part 'mock_remote_db.g.dart';

@RestApi()
@injectable
abstract class HomeRemoteDB {
  @factoryMethod
  factory HomeRemoteDB(@Named('BaseDioHome') Dio dio) = _HomeRemoteDB;

  @GET('/ka/home/')
  Future<HomeResponse> fetchHome();
}
