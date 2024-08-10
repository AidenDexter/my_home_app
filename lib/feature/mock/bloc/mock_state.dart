part of 'mock_bloc.dart';

@freezed
class MockState with _$MockState {
  bool get isProgress => maybeMap(
        orElse: () => false,
        progress: (_) => true,
      );

  const MockState._();

  const factory MockState.progress() = _ProgressMockState;

  const factory MockState.success({required Post post}) = _SuccessMockState;

  const factory MockState.error({required IErrorHandler errorHandler}) = _ErrorMockState;
}
