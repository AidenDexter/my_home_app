part of 'choose_area_bloc.dart';

@freezed
class ChooseAreaState with _$ChooseAreaState {
  const ChooseAreaState._();

  const factory ChooseAreaState.progress() = _ProgressChooseAreaState;

  const factory ChooseAreaState.success({required ChooseAreaResponse data}) = _SuccessChooseAreaState;

  const factory ChooseAreaState.error({required IErrorHandler errorHandler}) = _ErrorChooseAreaState;
}
