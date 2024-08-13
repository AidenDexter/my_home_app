import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class ThirdPartyModule {
  //Storages
  @preResolve // await prefs before registering SharedPreferences instance
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
