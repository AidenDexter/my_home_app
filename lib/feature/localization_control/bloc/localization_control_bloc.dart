import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../data/repository/localization_control_repository.dart';
import '../domain/locale_entity/locale_entity.dart';

part 'localization_control_bloc.freezed.dart';
part 'localization_control_event.dart';
part 'localization_control_state.dart';

@lazySingleton
class LocalizationControlBloc extends Bloc<LocalizationControlEvent, LocalizationControlState> {
  final ILocalizationControlRepository _repository;

  LocalizationControlBloc({required ILocalizationControlRepository repository})
      : _repository = repository,
        super(
          LocalizationControlState(
            currentLocalization: LocaleEntity.fromLanguageCode(
              repository.lastInitedLocale,
            ),
          ),
        ) {
    on<LocalizationControlEvent>(
      (event, emit) => event.map(
        changeLocalization: (event) => _changeLocalization(event, emit),
      ),
    );
  }

  Future<void> _changeLocalization(_ChangeLocalizationEvent event, Emitter<LocalizationControlState> emit) async {
    try {
      final locale = event.locale;
      await _repository.saveLocale(locale.languageCode);
      emit(LocalizationControlState(currentLocalization: locale));
    } on Object catch (_) {
      emit(state);
      rethrow;
    }
  }
}
