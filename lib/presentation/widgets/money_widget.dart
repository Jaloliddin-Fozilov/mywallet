import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mywallet/logic/balance/balance_cubit.dart';
import 'package:mywallet/logic/date/date_cubit.dart';
import 'package:mywallet/logic/expense/expense_cubit.dart';

class MoneyWidget extends StatelessWidget {
  const MoneyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(width: 2, color: Colors.black45),
            ),
            child: CircleAvatar(
              radius: 14,
              backgroundColor: Colors.transparent,
              child: BlocBuilder<BalanceCubit, BalanceState>(
                builder: (context, state) {
                  if (state is ChangeActiveDate) {
                    return IconButton(
                      icon: const Icon(Icons.arrow_left),
                      color: Colors.black45,
                      iconSize: 20,
                      padding: const EdgeInsets.all(0),
                      onPressed: () => context.read<DateCubit>().changeDate(
                            DateTime(
                              context.read<DateCubit>().getActiveDate.year,
                              context.read<DateCubit>().getActiveDate.month - 1,
                            ),
                          ),
                    );
                  }
                  return IconButton(
                    icon: const Icon(Icons.arrow_left),
                    color: Colors.black45,
                    iconSize: 20,
                    padding: const EdgeInsets.all(0),
                    onPressed: () => context.read<DateCubit>().changeDate(
                          DateTime(
                            context.read<DateCubit>().getActiveDate.year,
                            context.read<DateCubit>().getActiveDate.month - 1,
                          ),
                        ),
                  );
                },
              ),
            ),
          ),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: NumberFormat.currency(symbol: "").format(
                    context.watch<BalanceCubit>().budget -
                        context.watch<ExpenseCubit>().monthExpense,
                  ),
                  style: const TextStyle(
                    fontSize: 34,
                  ),
                ),
                const TextSpan(
                  text: " sum",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(width: 2, color: Colors.black45),
            ),
            child: CircleAvatar(
              radius: 14,
              backgroundColor: Colors.transparent,
              child: IconButton(
                icon: const Icon(Icons.arrow_right),
                color: Colors.black45,
                iconSize: 20,
                padding: const EdgeInsets.all(0),
                onPressed: () => context.read<DateCubit>().changeDate(
                      DateTime(
                        context.read<DateCubit>().getActiveDate.year,
                        context.read<DateCubit>().getActiveDate.month + 1,
                      ),
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
