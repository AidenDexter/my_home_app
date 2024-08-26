part of 'currency_control_bloc.dart';

@freezed
class CurrencyControlEvent with _$CurrencyControlEvent {
  const factory CurrencyControlEvent.change({required Currency currency}) = _ReadCurrencyControlEvent;
}
