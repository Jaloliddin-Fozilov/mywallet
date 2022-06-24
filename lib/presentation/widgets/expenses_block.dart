import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mywallet/logic/expense/expense_cubit.dart';
import 'package:mywallet/presentation/widgets/expense_widget.dart';

class ExpensesBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final expenses = context.watch<ExpenseCubit>().state.expenses!;
    return Expanded(
      child: Scaffold(
        backgroundColor: const Color(0xffEFEEFC),
        body: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(50.0),
              topLeft: Radius.circular(50.0),
            ),
          ),
          child: expenses.isNotEmpty
              ? ListView.builder(
                  itemBuilder: (ctx, index) {
                    return ExpenseWidget(
                      expenses[index],
                    );
                  },
                  itemCount: expenses.length,
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.account_balance_wallet,
                        size: 36,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "The list is empty.",
                        style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).primaryColor),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
