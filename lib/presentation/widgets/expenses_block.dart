import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/date/date_bloc.dart';
import '../../logic/expense/expense_bloc.dart';
import 'expense_widget.dart';

class ExpensesBlock extends StatefulWidget {
  const ExpensesBlock({Key? key}) : super(key: key);

  @override
  State<ExpensesBlock> createState() => _ExpensesBlockState();
}

class _ExpensesBlockState extends State<ExpensesBlock> {
  @override
  Widget build(BuildContext context) {
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
          child: BlocListener<DateBloc, DateState>(
            listener: (context, state) {
              if (state is ChangeActiveDate) {
                context.read<ExpenseBloc>().add(LoadExpenseEvent());
              }
            },
            child: BlocBuilder<ExpenseBloc, ExpenseState>(
              builder: (context, state) {
                context.read<ExpenseBloc>().add(LoadExpenseEvent());
                if (state is ExpenseLoaded) {
                  return state.expenses.isEmpty
                      ? Center(
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
                        )
                      : ListView.builder(
                          itemCount: state.expenses.length,
                          itemBuilder: (ctx, index) => ExpenseWidget(
                            expense: state.expenses[index],
                          ),
                        );
                }
                return Center(
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
