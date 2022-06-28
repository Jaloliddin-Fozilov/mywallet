import 'package:flutter/material.dart';
import 'package:mywallet/logic/balance/balance_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBalance extends StatelessWidget {
  final inputBalance = TextEditingController();

  double budget = 0.0;

  AddBalance({Key? key}) : super(key: key);

  void submitBalance(BuildContext context) {
    if (inputBalance.text.isEmpty) {
      return;
    }
    budget = double.parse(inputBalance.text);
    context.read<BalanceCubit>().changeBudget(budget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: "Enter your monthly budget",
            ),
            controller: inputBalance,
            keyboardType: TextInputType.number,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("CLOSE"),
              ),
              ElevatedButton(
                onPressed: () {
                  submitBalance(context);
                  Navigator.of(context).pop();
                },
                child: const Text("SUBMIT"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
