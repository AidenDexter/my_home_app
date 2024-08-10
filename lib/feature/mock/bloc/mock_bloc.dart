import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/error/error_handler.dart';
import '../domain/entity/post.dart';
import '../domain/repository/i_mock_repository.dart';

part 'mock_bloc.freezed.dart';
part 'mock_event.dart';
part 'mock_state.dart';

class MockBloc extends Bloc<MockEvent, MockState> {
  final IMockRepository _repository;

  MockBloc({required IMockRepository repository})
      : _repository = repository,
        super(const MockState.progress()) {
    on<MockEvent>(
      (event, emit) => event.map(
        read: (event) => _read(event, emit),
      ),
    );
  }

  Future<void> _read(_ReadMockEvent event, Emitter<MockState> emit) async {
    try {
      final post = await _repository.getPost(1);
      emit(MockState.success(post: post));
    } on Object catch (error) {
      emit(MockState.error(errorHandler: error.toHandler));
    }
  }
}
