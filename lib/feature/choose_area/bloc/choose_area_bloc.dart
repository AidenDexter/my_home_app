import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/error/error_handler.dart';
import '../domain/entity/choose_area_response.dart';
import '../domain/repository/i_choose_area_repository.dart';

part 'choose_area_bloc.freezed.dart';
part 'choose_area_event.dart';
part 'choose_area_state.dart';

class ChooseAreaBloc extends Bloc<ChooseAreaEvent, ChooseAreaState> {
  final IChooseAreaRepository _repository;

  ChooseAreaBloc({required IChooseAreaRepository repository})
      : _repository = repository,
        super(const ChooseAreaState.progress()) {
    on<ChooseAreaEvent>(
      (event, emit) => event.map(
        read: (event) => _read(event, emit),
      ),
    );
  }

  Future<void> _read(_ReadChooseAreaEvent event, Emitter<ChooseAreaState> emit) async {
    try {
      final data = await _repository.fetchCities();
      emit(ChooseAreaState.success(data: data));
    } on Object catch (error) {
      emit(ChooseAreaState.error(errorHandler: error.toHandler));
    }
  }
}
