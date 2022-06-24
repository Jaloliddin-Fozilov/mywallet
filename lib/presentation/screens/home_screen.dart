import 'package:flutter/material.dart';
import 'package:mywallet/presentation/widgets/add_expense_modal.dart';
import 'package:mywallet/presentation/widgets/expenses_block.dart';

import '../widgets/active_date.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My wallet'),
        actions: [
          IconButton(
            onPressed: () {
              // showModalBottomSheet(
              //   isScrollControlled: true,
              //   isDismissible: false,
              //   context: context,
              //   builder: (ctx) {
              //     return AddExpenseModal();
              //   },
              // );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          ActiveDate(),
          ExpensesBlock(),
        ],
      ),
    );
  }
}
