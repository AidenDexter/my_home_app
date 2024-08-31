
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../domain/entity/home_response.dart';

part 'home_remote_db.g.dart';

@RestApi()
@injectable
abstract class HomeRemoteDB {
  @factoryMethod
  factory HomeRemoteDB(@Named('BaseDioHome') Dio dio) = _HomeRemoteDB;

  @GET('/{locale}/home/')
  Future<HomeResponse> fetchHome(@Path() String locale);
}
