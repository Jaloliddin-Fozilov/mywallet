part of 'expense_bloc.dart';

@immutable
abstract class ExpenseState {
  final List<Expense>? expenses;

  const ExpenseState({this.expenses});
}

class ExpenseInitial extends ExpenseState {
  final List<Expense> expenses;

  const ExpenseInitial(this.expenses) : super(expenses: expenses);
}

class ExpenseAdded extends ExpenseState {}

class ExpenseLoaded extends ExpenseState {
  final List<Expense> expenses;

  const ExpenseLoaded(this.expenses) : super(expenses: expenses);
}

class DeleteExpense extends ExpenseState {}

class ExpenseError extends ExpenseState {
  final String message;
  const ExpenseError(this.message);
}
