import 'package:freezed_annotation/freezed_annotation.dart';

part 'field_error_model.freezed.dart';
part 'field_error_model.g.dart';

@freezed
class FieldErrorModel with _$FieldErrorModel {
  const factory FieldErrorModel({
    required String field,
    required String message,
  }) = _FieldErrorModel;

  /// Generate Class from Map<String, Object?>
  factory FieldErrorModel.fromJson(Map<String, Object?> json) => _$FieldErrorModelFromJson(json);
}
