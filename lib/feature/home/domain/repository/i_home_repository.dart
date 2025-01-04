import 'package:flutter/foundation.dart' show immutable;

import '../../../search/domain/entity/search_response.dart';

@immutable
abstract interface class IHomeRepository {
  Future<List<SearchItem>> fetchSuperVipItems(String locale);

  Future<List<SearchItem>> fetchVipPlusItems(String locale);
}
