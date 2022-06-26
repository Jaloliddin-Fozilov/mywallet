import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:mywallet/logic/user/user_cubit.dart';

import '../../data/models/expense.dart';
import '../cubit/date_cubit.dart';

part 'expense_state.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  final UserCubit userCubit;

  ExpenseCubit({required this.userCubit})
      : super(
          ExpenseInitial([
            Expense(
              id: UniqueKey().toString(),
              title: 'Phone',
              date: DateTime(2022, 06),
              userId: '1',
              price: 200456,
              icon: Icons.phone,
            ),
            Expense(
              id: UniqueKey().toString(),
              title: 'Phone',
              date: DateTime.now(),
              userId: '1',
              price: 200456,
              icon: Icons.phone,
            ),
            Expense(
              id: UniqueKey().toString(),
              title: 'Phone',
              date: DateTime(2022, 05),
              userId: '1',
              price: 200456,
              icon: Icons.phone,
            ),
          ]),
        );

  void getExpenses() {
    final user = userCubit.currentUser;
    final expenses =
        state.expenses!.where((expense) => expense.userId == user.id).toList();
    print(expenses);
    emit(ExpenseInitial(expenses));
    emit(ExpenseLoaded(expenses));
  }

  void addExpense(
    String title,
    double price,
    IconData icon,
    DateTime date,
  ) {
    final user = userCubit.currentUser;
    try {
      final todo = Expense(
        id: UniqueKey().toString(),
        title: title,
        userId: user.id,
        date: date,
        price: price,
        icon: icon,
      );
      final expenses = [...state.expenses!, todo];
      emit(ExpenseAdded());
      emit(ExpenseLoaded(expenses));
    } catch (e) {
      print('$e added error');
      emit(const ExpenseError('Error occured'));
    }
  }

  void deleteExpense(String id) {
    final expenses = state.expenses;
    expenses!.removeWhere((expense) => expense.id == id);
    emit(DeleteExpense());
    emit(ExpenseLoaded(expenses));
  }
}
