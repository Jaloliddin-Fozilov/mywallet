import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/expense/expense_bloc.dart';
import '../widgets/active_date.dart';
import '../widgets/add_expense_modal.dart';
import '../widgets/expenses_block.dart';
import '../widgets/money_widget.dart';
import '../widgets/percent_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ExpenseBloc>().add(LoadExpenseEvent());
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
        children: const [
          ActiveDate(),
          MoneyWidget(),
          PercentWidget(),
          ExpensesBlock(),
        ],
      ),
    );
  }
}
