import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'balance_state.dart';

class BalanceCubit extends Cubit<BalanceState> {
  BalanceCubit() : super(const BalanceInitial(0));

  double get budget {
    return state.balance!;
  }

  void changeBudget(double budget) {
    emit(ChangeBalance(budget));
  }
}
