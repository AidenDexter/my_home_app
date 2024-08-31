part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const HomeState._();

  const factory HomeState.progress() = _ProgressHomeState;

  const factory HomeState.success({required List<Sections> sections}) = _SuccessHomeState;

  const factory HomeState.error({required IErrorHandler errorHandler}) = _ErrorHomeState;
}
