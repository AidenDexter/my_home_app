part of 'localization_control_bloc.dart';

@freezed
class LocalizationControlEvent with _$LocalizationControlEvent {
  const factory LocalizationControlEvent.changeLocalization({required LocaleEntity locale}) = _ChangeLocalizationEvent;
}
