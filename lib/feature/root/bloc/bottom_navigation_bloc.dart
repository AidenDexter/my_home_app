import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bottom_navigation_event.dart';
part 'bottom_navigation_state.dart';
part 'bottom_navigation_bloc.freezed.dart';

class BottomNavigationBloc extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc() : super(const BottomNavigationState()) {
    on<_PageChanged>(_onPageChanged);
  }

  Future<void> _onPageChanged(_PageChanged event, Emitter<BottomNavigationState> emit) async {
    emit(BottomNavigationState(currentPageIndex: event.newIndex));
  }
}
