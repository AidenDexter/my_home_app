part of 'choose_area_bloc.dart';

@freezed
class ChooseAreaState with _$ChooseAreaState {
  const ChooseAreaState._();

  Datum? cityById(int id) => maybeMap(
        orElse: () => null,
        success: (state) => state.data.data.firstWhere((city) => city.id == id),
      );

  Datum? districtById(int cityId, int districtId) => maybeMap(
        orElse: () => null,
        success: (state) => state.data.data
            .firstWhere((city) => city.id == cityId)
            .districts!
            .firstWhere((district) => district.id == districtId),
      );

  const factory ChooseAreaState.progress() = _ProgressChooseAreaState;

  const factory ChooseAreaState.success({required ChooseAreaResponse data}) = _SuccessChooseAreaState;

  const factory ChooseAreaState.error({required IErrorHandler errorHandler}) = _ErrorChooseAreaState;
}
