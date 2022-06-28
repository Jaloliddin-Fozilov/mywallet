part of 'balance_bloc.dart';

@immutable
abstract class BalanceEvent {}

class ChangeBudgetEvent extends BalanceEvent {
  final double budget;

  ChangeBudgetEvent(this.budget);
}
