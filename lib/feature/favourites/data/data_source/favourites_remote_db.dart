import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'favourites_remote_db.g.dart';

@RestApi()
@injectable
abstract class FavouritesRemoteDB {
  @factoryMethod
  factory FavouritesRemoteDB(@Named('BaseDio') Dio dio) = _FavouritesRemoteDB;
}
