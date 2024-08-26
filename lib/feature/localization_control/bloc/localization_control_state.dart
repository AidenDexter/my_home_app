part of 'localization_control_bloc.dart';

@freezed
class LocalizationControlState with _$LocalizationControlState {
  const factory LocalizationControlState({required LocaleEntity currentLocalization}) = _LocalizationControlState;
}
