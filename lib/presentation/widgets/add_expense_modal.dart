import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mywallet/logic/date/date_cubit.dart';
// import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:mywallet/logic/expense/expense_cubit.dart';

class AddExpenseModal extends StatefulWidget {
  const AddExpenseModal({Key? key}) : super(key: key);

  @override
  State<AddExpenseModal> createState() => _AddExpenseModalState();
}

class _AddExpenseModalState extends State<AddExpenseModal> {
  DateTime? selectedDay = DateTime.now();
  IconData? selectedIcon = Icons.add;

  final expenseTitle = TextEditingController();
  final expensePrice = TextEditingController();

  void submitExpense(BuildContext context) {
    if (expenseTitle.text.isEmpty &&
        expensePrice.text.isEmpty &&
        selectedDay == null &&
        selectedIcon == null) {
      return;
    }
    context.read<ExpenseCubit>().addExpense(expenseTitle.text,
        double.parse(expensePrice.text), selectedIcon!, selectedDay!);
    Navigator.of(context).pop();
  }

  void selectDateDay(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((selectedDateDay) {
      if (selectedDateDay != null) {
        setState(() {
          selectedDay = selectedDateDay;
        });
      }
    });
  }

  void selectIcon(BuildContext context) {
    // FlutterIconPicker.showIconPicker(
    //   context,
    //   iconPackModes: [IconPack.material],
    // ).then(
    //   (selected) {
    //     if (selected != null) {
    //       setState(() {
    //         selectedIcon = selected;
    //       });
    //     }
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom > 0
              ? MediaQuery.of(context).viewInsets.bottom + 16
              : 16,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150.0,
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: "Expense name",
                    ),
                    controller: expenseTitle,
                  ),
                ),
                SizedBox(
                  width: 150.0,
                  child: TextField(
                    decoration: const InputDecoration(labelText: "Cost amount"),
                    controller: expensePrice,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedDay == null
                      ? "The date has not yet been selected!"
                      : DateFormat("MMMM  d, yyyy").format(selectedDay!),
                ),
                TextButton(
                  onPressed: () {
                    selectDateDay(context);
                  },
                  child: const Text("SELECT A DAY"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                selectedIcon != null
                    ? Icon(selectedIcon)
                    : const Text("Icon not selected!"),
                TextButton(
                  onPressed: () {
                    selectIcon(context);
                  },
                  child: const Text("SELECT ICON"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("CLOSE"),
                ),
                ElevatedButton(
                  onPressed: () {
                    submitExpense(context);
                  },
                  child: const Text("SUBMIT"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
