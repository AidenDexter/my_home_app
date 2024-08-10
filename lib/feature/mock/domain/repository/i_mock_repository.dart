import 'package:flutter/foundation.dart' show immutable;

import '../entity/post.dart';

@immutable
abstract interface class IMockRepository {
  Future<Post> getPost(int id);
}
