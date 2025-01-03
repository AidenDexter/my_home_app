import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/error/error_handler.dart';
import '../../search/domain/entity/search_response.dart';
import '../domain/repository/i_home_repository.dart';

part 'home_super_vip.freezed.dart';

@freezed
class HomeSuperVipState with _$HomeSuperVipState {
  const HomeSuperVipState._();

  const factory HomeSuperVipState.progress() = _ProgressHomeSuperVipState;

  const factory HomeSuperVipState.success({required List<SearchItem> items}) = _SuccessHomeSuperVipState;

  const factory HomeSuperVipState.error({required IErrorHandler errorHandler}) = _ErrorHomeSuperVipState;
}

@freezed
class HomeSuperVipEvent with _$HomeSuperVipEvent {
  const factory HomeSuperVipEvent.read({required String locale}) = _ReadHomeSuperVipEvent;
}

class HomeSuperVipBloc extends Bloc<HomeSuperVipEvent, HomeSuperVipState> {
  final IHomeRepository _repository;

  HomeSuperVipBloc({required IHomeRepository repository})
      : _repository = repository,
        super(const HomeSuperVipState.progress()) {
    on<HomeSuperVipEvent>(
      (event, emit) => event.map(
        read: (event) => _read(event, emit),
      ),
    );
  }

  Future<void> _read(_ReadHomeSuperVipEvent event, Emitter<HomeSuperVipState> emit) async {
    emit(const HomeSuperVipState.progress());
    try {
      final response = await _repository.fetchSuperVipItems(event.locale);
      emit(HomeSuperVipState.success(items: response));
    } on Object catch (error) {
      emit(HomeSuperVipState.error(errorHandler: error.toHandler));
    }
  }
}
