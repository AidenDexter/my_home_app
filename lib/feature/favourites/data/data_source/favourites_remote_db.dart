import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../search/domain/entity/search_response.dart';

part 'favourites_remote_db.g.dart';

@RestApi()
@injectable
abstract class FavouritesRemoteDB {
  @factoryMethod
  factory FavouritesRemoteDB(@Named('BaseDioTnet') Dio dio) = _FavouritesRemoteDB;

  @GET('/statements?q={id}')
  Future<SearchResponse> fetchFavouriteInfo(@Path() String id, @Header('locale') String locale);
}
