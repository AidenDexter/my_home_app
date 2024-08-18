part of 'bottom_navigation_bloc.dart';

@freezed
class BottomNavigationState with _$BottomNavigationState {
  const factory BottomNavigationState({
    @Default(0) int currentPageIndex,
  }) = _BottomNavigationState;
}
