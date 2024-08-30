import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/error/error_handler.dart';
import '../domain/entity/home_response.dart';
import '../domain/repository/i_home_repository.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IHomeRepository _repository;

  HomeBloc({required IHomeRepository repository})
      : _repository = repository,
        super(const HomeState.progress()) {
    on<HomeEvent>(
      (event, emit) => event.map(
        read: (event) => _read(event, emit),
      ),
    );
  }

  Future<void> _read(_ReadHomeEvent event, Emitter<HomeState> emit) async {
    try {
      final response = await _repository.fetchHome();
      emit(HomeState.success(sections: response.data ?? []));
    } on Object catch (error) {
      emit(HomeState.error(errorHandler: error.toHandler));
    }
  }
}
