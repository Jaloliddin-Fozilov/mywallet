part of 'date_bloc.dart';

@immutable
abstract class DateEvent {}

class ChangeDateEvent extends DateEvent {
  final DateTime date;

  ChangeDateEvent(this.date);
}
