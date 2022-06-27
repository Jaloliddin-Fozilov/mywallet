import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mywallet/presentation/widgets/add_expense_modal.dart';
import 'package:mywallet/presentation/widgets/expenses_block.dart';
import 'package:mywallet/presentation/widgets/percent_widget.dart';

import '../../logic/expense/expense_cubit.dart';
import '../widgets/active_date.dart';
import '../widgets/money_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ExpenseCubit>().getExpenses();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My wallet'),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                isDismissible: false,
                context: context,
                builder: (ctx) {
                  return const AddExpenseModal();
                },
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const ActiveDate(),
          MoneyWidget(totalPriceSum: 456.45),
          PercentWidget(() {}, 456.45, 42),
          const ExpensesBlock(),
        ],
      ),
    );
  }
}
