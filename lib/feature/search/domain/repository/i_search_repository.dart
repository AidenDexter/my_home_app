import 'package:flutter/foundation.dart' show immutable;

import '../entity/search_response.dart';

@immutable
abstract interface class ISearchRepository {
  Future<List<SearchItem>> search(String filter, String locale);
}
