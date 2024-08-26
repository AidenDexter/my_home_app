import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../domain/entity/search_response.dart';

part 'search_remote_db.g.dart';

@RestApi()
@injectable
abstract class SearchRemoteDB {
  @factoryMethod
  factory SearchRemoteDB(@Named('BaseDioTnet') Dio dio) = _SearchRemoteDB;

  @GET('/statements?{filter}')
  Future<SearchResponse> search(@Path() String filter);
}
