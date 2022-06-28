part of 'date_bloc.dart';

@immutable
abstract class DateState {
  final DateTime? date;

  const DateState({this.date});
}

class DateInitial extends DateState {
  const DateInitial(DateTime dateTime) : super(date: dateTime);
}

class ChangeActiveDate extends DateState {
  final DateTime date;
  const ChangeActiveDate(this.date) : super(date: date);
}
