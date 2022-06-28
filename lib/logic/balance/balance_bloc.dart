import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'balance_event.dart';
part 'balance_state.dart';

class BalanceBloc extends Bloc<BalanceEvent, BalanceState> {
  BalanceBloc() : super(const BalanceInitial(0)) {
    on<ChangeBudgetEvent>(_changeBudget);
  }

  double get budget {
    return state.balance!;
  }

  void _changeBudget(ChangeBudgetEvent event, Emitter<BalanceState> emit) {
    emit(ChangeBalance(event.budget));
  }
}
