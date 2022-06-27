part of 'balance_cubit.dart';

@immutable
abstract class BalanceState {
  final double? balance;

  const BalanceState({this.balance});
}

class BalanceInitial extends BalanceState {
  const BalanceInitial(double balance) : super(balance: balance);
}

class ChangeBalance extends BalanceState {
  final double budget;
  const ChangeBalance(this.budget) : super(balance: budget);
}
