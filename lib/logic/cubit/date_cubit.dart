import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mywallet/data/models/expense.dart';
import 'package:mywallet/logic/expense/expense_cubit.dart';

part 'date_state.dart';

class DateCubit extends Cubit<DateState> {
  late final StreamSubscription expenseCubitSubscription;
  final ExpenseCubit expenseCubit;
  DateCubit(this.expenseCubit) : super(DateInitial(DateTime.now())) {
    expenseCubitSubscription = expenseCubit.stream.listen((ExpenseState state) {
      getExpensesByFilter();
    });
  }

  void getExpensesByFilter() {
    print('${state.date!} state.date');
    final expenses = expenseCubit.state.expenses!
        .where((expense) =>
            expense.date.month == state.date!.month &&
            expense.date.year == state.date!.year)
        .toList();
    emit(ChangeExpensesDate(expenses));
  }

  void changeDate(DateTime date) {
    emit(ChangeDateState(date));
  }

  void previousMonth(DateTime date) {
    print('${state.date!} previousMonth');
    DateTime activeDate = DateTime(date.year, date.month - 1);
    emit(ChangeDateState(activeDate));
  }

  void nextMonth(DateTime date) {
    DateTime activeDate = DateTime(date.year, date.month + 1);
    emit(ChangeDateState(activeDate));
  }

  @override
  Future<void> close() {
    expenseCubitSubscription.cancel();
    return super.close();
  }
}
