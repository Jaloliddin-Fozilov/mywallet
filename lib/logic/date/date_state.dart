part of 'date_cubit.dart';

@immutable
abstract class DateState {
  final DateTime? date;

  const DateState({this.date});
}

class DateInitial extends DateState {
  const DateInitial(DateTime dateTime) : super(date: dateTime);
}

class ChangeExpensesDate extends DateState {
  final List<Expense> expenses;

  const ChangeExpensesDate(this.expenses);
}

class ChangeActiveDate extends DateState {
  final DateTime date;
  const ChangeActiveDate(this.date) : super(date: date);
}
