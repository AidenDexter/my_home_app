import 'package:flutter/foundation.dart' show immutable;

import '../entity/choose_area_response.dart';

@immutable
abstract interface class IChooseAreaRepository {
  Future<ChooseAreaResponse> fetchCities();
}
