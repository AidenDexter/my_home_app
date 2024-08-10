import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post {
  const factory Post({
    required int id,
    required int userId,
    required String body,
    required String title,
  }) = _Post;

  /// Generate Class from Map<String, Object?>
  factory Post.fromJson(Map<String, Object?> json) => _$PostFromJson(json);
}
