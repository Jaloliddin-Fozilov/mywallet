part of 'expense_bloc.dart';

@immutable
abstract class ExpenseEvent {}

class LoadExpenseEvent extends ExpenseEvent {}

class AddNewExpenseEvent extends ExpenseEvent {
  final String title;
  final double price;
  final IconData icon;
  final DateTime date;

  AddNewExpenseEvent(this.title, this.price, this.icon, this.date);
}

class DeleteExpenseEvent extends ExpenseEvent {
  final String id;
  DeleteExpenseEvent(this.id);
}
