import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../data/models/expense.dart';
import '../date/date_bloc.dart';
import '../user/user_bloc.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final UserBloc userBloc;
  final DateBloc dateBloc;

  List<Expense> _list = [
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
    )
  ];

  List<Expense> get expensesList {
    return [..._list];
  }

  ExpenseBloc(this.userBloc, this.dateBloc)
      : super(ExpenseInitial([
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
          )
        ])) {
    on<LoadExpenseEvent>(_getExpenses);
    on<AddNewExpenseEvent>(_addExpense);
    on<DeleteExpenseEvent>(_deleteExpense);
  }

  void _getExpenses(LoadExpenseEvent event, Emitter<ExpenseState> emit) {
    final user = userBloc.currentUser;
    final date = dateBloc.getActiveDate;
    emit(ExpenseLoaded(expensesList));
    final expenses = state.expenses!
        .where((expense) =>
            expense.userId == user.id &&
            expense.date.month == date.month &&
            expense.date.year == date.year)
        .toList();
    emit(ExpenseLoaded(expenses));
  }

  void _addExpense(AddNewExpenseEvent event, Emitter<ExpenseState> emit) {
    final user = userBloc.currentUser;
    try {
      final todo = Expense(
        id: UniqueKey().toString(),
        title: event.title,
        userId: user.id,
        date: event.date,
        price: event.price,
        icon: event.icon,
      );
      _list.add(todo);
      final List<Expense> expenses = _list;
      emit(ExpenseAdded());
      emit(ExpenseLoaded(expenses));
    } catch (e) {
      print('$e added error');
      emit(const ExpenseError('Error occured'));
    }
  }

  void _deleteExpense(DeleteExpenseEvent event, Emitter<ExpenseState> emit) {
    final expenses = state.expenses;
    expenses!.removeWhere((expense) => expense.id == event.id);
    emit(DeleteExpense());
    emit(ExpenseLoaded(expenses));
  }

  double get monthExpense {
    return state.expenses!.fold(0, (price, list) => price + list.price);
  }
}
