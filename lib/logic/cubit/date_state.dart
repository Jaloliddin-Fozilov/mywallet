part of 'date_cubit.dart';

@immutable
abstract class DateState {
  final DateTime? date;

  const DateState({this.date});
}

class DateInitial extends DateState {
  const DateInitial(DateTime date) : super(date: date);
}

class ChangeDateState extends DateState {
  final DateTime activeDate;
  const ChangeDateState(this.activeDate) : super(date: activeDate);
}

class ChangeExpensesDate extends DateState {
  final List<Expense> expenses;

  ChangeExpensesDate(this.expenses);
}
