import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../search/domain/entity/search_response.dart';

part 'home_remote_db.g.dart';

@RestApi()
@injectable
abstract class HomeRemoteDB {
  @factoryMethod
  factory HomeRemoteDB(@Named('BaseDioTnet') Dio dio) = _HomeRemoteDB;

  @GET('/statements?is_super_vip=true&per_page=12')
  Future<SearchResponse> fetchSuperVipItems(@Header('locale') String locale);

  @GET('/statements?is_vip_plus=true&per_page=12')
  Future<SearchResponse> fetchVipPlusItems(@Header('locale') String locale);
}
