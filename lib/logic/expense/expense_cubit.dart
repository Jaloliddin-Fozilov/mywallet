import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:mywallet/logic/user/user_cubit.dart';

import '../../data/models/expense.dart';

part 'expense_state.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  final UserCubit userCubit;

  ExpenseCubit({required this.userCubit})
      : super(
          ExpenseInitial([
            Expense(
              id: UniqueKey().toString(),
              title: 'Phone',
              day: DateTime.now(),
              userId: '1',
              price: 200456,
              icon: Icons.phone,
            )
          ]),
        );

  void getExpenses(DateTime date) {
    final user = userCubit.currentUser;
    final expenses = state.expenses!
        .where((expense) =>
            expense.userId == user.id &&
            expense.day.month == date.month &&
            expense.day.year == date.year)
        .toList();
    emit(ExpenseLoaded(expenses));
  }

  void addExpense(
    String title,
    double price,
    IconData icon,
  ) {
    final user = userCubit.currentUser;
    try {
      final todo = Expense(
        id: UniqueKey().toString(),
        title: title,
        userId: user.id,
        day: DateTime.now(),
        price: price,
        icon: icon,
      );
      final expenses = [...state.expenses!, todo];
      emit(ExpenseAdded());
      emit(ExpenseLoaded(expenses));
    } catch (e) {
      emit(const ExpenseError('Error occured'));
    }
  }

  void deleteExpense(String id) {
    final expenses = state.expenses;
    expenses!.removeWhere((expense) => expense.id == id);
    emit(DeleteExpense());
    emit(ExpenseLoaded(expenses));
  }

  List<Expense> sortByMonth(DateTime date) {
    return state.expenses!
        .where((expense) =>
            expense.day.month == date.month && expense.day.year == date.year)
        .toList();
  }
}
