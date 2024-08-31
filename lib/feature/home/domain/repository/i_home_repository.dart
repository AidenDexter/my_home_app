import 'package:flutter/foundation.dart' show immutable;

import '../entity/home_response.dart';

@immutable
abstract interface class IHomeRepository {
  Future<HomeResponse> fetchHome(String locale);
}
