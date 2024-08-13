part of 'mock_bloc.dart';

@freezed
class MockEvent with _$MockEvent {
  const factory MockEvent.read() = _ReadMockEvent;
}
