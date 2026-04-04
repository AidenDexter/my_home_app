import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../domain/entity/choose_area_response.dart';

part 'choose_area_remote_db.g.dart';

@RestApi()
@injectable
abstract class ChooseAreaRemoteDB {
  @factoryMethod
  factory ChooseAreaRemoteDB(@Named('BaseDioHome') Dio dio) = _ChooseAreaRemoteDB;

  @GET('https://api-locations.tnet.ge/v2/cities')
  Future<ChooseAreaResponse> fetchCities();
}
