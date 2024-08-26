import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/entity/currency.dart';
import '../domain/repository/i_currency_control_repository.dart';

part 'currency_control_bloc.freezed.dart';
part 'currency_control_event.dart';
part 'currency_control_state.dart';

class CurrencyControlBloc extends Bloc<CurrencyControlEvent, CurrencyControlState> {
  final ICurrencyControlRepository _repository;

  CurrencyControlBloc({required ICurrencyControlRepository repository})
      : _repository = repository,
        super(CurrencyControlState(repository.lastUsedCurrency)) {
    on<CurrencyControlEvent>(
      (event, emit) => event.map(
        change: (event) => _change(event, emit),
      ),
    );
  }

  Future<void> _change(_ReadCurrencyControlEvent event, Emitter<CurrencyControlState> emit) async {
    emit(CurrencyControlState(event.currency));
    await _repository.saveCurrency(event.currency);
  }
}
