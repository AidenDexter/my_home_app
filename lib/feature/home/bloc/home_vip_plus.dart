import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/error/error_handler.dart';
import '../../search/domain/entity/search_response.dart';
import '../domain/repository/i_home_repository.dart';

part 'home_vip_plus.freezed.dart';

@freezed
class HomeVipPlusState with _$HomeVipPlusState {
  const HomeVipPlusState._();

  const factory HomeVipPlusState.progress() = _ProgressHomeVipPlusState;

  const factory HomeVipPlusState.success({required List<SearchItem> items}) = _SuccessHomeVipPlusState;

  const factory HomeVipPlusState.error({required IErrorHandler errorHandler}) = _ErrorHomeVipPlusState;
}

@freezed
class HomeVipPlusEvent with _$HomeVipPlusEvent {
  const factory HomeVipPlusEvent.read({required String locale}) = _ReadHomeVipPlusEvent;
}

class HomeVipPlusBloc extends Bloc<HomeVipPlusEvent, HomeVipPlusState> {
  final IHomeRepository _repository;

  HomeVipPlusBloc({required IHomeRepository repository})
      : _repository = repository,
        super(const HomeVipPlusState.progress()) {
    on<HomeVipPlusEvent>(
      (event, emit) => event.map(
        read: (event) => _read(event, emit),
      ),
    );
  }

  Future<void> _read(_ReadHomeVipPlusEvent event, Emitter<HomeVipPlusState> emit) async {
    emit(const HomeVipPlusState.progress());
    try {
      final response = await _repository.fetchVipPlusItems(event.locale);
      emit(HomeVipPlusState.success(items: response));
    } on Object catch (error) {
      emit(HomeVipPlusState.error(errorHandler: error.toHandler));
    }
  }
}
