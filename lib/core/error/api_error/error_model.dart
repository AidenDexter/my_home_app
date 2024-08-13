import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_model.freezed.dart';
part 'error_model.g.dart';

@freezed
class ErrorModel with _$ErrorModel {
  const factory ErrorModel({
    required String name,
    required String message,
    required int? status,
    required String? type,
  }) = _ErrorModel;

  /// Generate Class from Map<String, Object?>
  factory ErrorModel.fromJson(Map<String, Object?> json) => _$ErrorModelFromJson(json);
}
