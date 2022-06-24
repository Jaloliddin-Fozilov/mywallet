import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mywallet/data/models/expense.dart';

import '../../logic/expense/expense_cubit.dart';

class ExpenseWidget extends StatefulWidget {
  final Expense expense;
  ExpenseWidget(this.expense);

  @override
  State<ExpenseWidget> createState() => _ExpenseWidgetState();
}

class _ExpenseWidgetState extends State<ExpenseWidget> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        // Then show a snackbar.
        context.read<ExpenseCubit>().deleteExpense(widget.expense.id);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("${widget.expense.title} o'chirildi")));
      },
      // Show a red background as the item is swiped away.
      background: Container(
        padding: const EdgeInsets.all(24),
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: const Icon(Icons.delete_forever, color: Colors.white),
      ),
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
          ),
          child: CircleAvatar(
            radius: 24,
            backgroundColor: Color(0xffEFEEFC),
            child: Icon(
              (widget.expense.icon),
              color: Colors.black45,
              size: 24,
            ),
          ),
        ),
        title: Text(
          widget.expense.title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          DateFormat("d-MMMM-yyyy").format(widget.expense.day),
          style: const TextStyle(fontSize: 12),
        ),
        trailing: Text("${widget.expense.price} so'm"),
      ),
    );
  }
}
