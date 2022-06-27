import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mywallet/logic/expense/expense_cubit.dart';
import 'package:mywallet/presentation/widgets/add_balance.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:intl/intl.dart';

import '../../logic/balance/balance_cubit.dart';

class PercentWidget extends StatefulWidget {
  const PercentWidget({Key? key}) : super(key: key);

  @override
  State<PercentWidget> createState() => _PercentWidgetState();
}

class _PercentWidgetState extends State<PercentWidget> {
  double percent = 0;

  double get percentCalc {
    BlocListener<BalanceCubit, BalanceState>(
      listener: (context, state) {
        if (state is ChangeBalance) {
          setState(() {
            percent = context.read<ExpenseCubit>().monthExpense /
                (context.read<BalanceCubit>().budget / 100);
          });
        }
      },
    );
    return percent;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xffEFEEFC),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(50.0),
          topLeft: Radius.circular(50.0),
        ),
      ),
      padding: const EdgeInsets.only(top: 14, left: 14, right: 14, bottom: 24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  const Text(
                    "Salary: ",
                    style: TextStyle(fontSize: 12),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isDismissible: false,
                        builder: (ctx) {
                          return AddBalance();
                        },
                      );
                    },
                    icon: const Icon(Icons.edit),
                    label: Text(
                      "${NumberFormat.currency(symbol: "").format(context.watch<BalanceCubit>().budget)} sum",
                      style: const TextStyle(
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                "${percentCalc.toStringAsFixed(1)}%",
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
          LinearPercentIndicator(
            alignment: MainAxisAlignment.spaceAround,
            width: 320,
            lineHeight: 5,
            animationDuration: 50,
            percent: double.parse(percentCalc.toStringAsFixed(1)) / 100 < 1.0
                ? double.parse(percentCalc.toStringAsFixed(1)) / 100
                : 1,
            backgroundColor: Colors.grey,
            linearGradient: const LinearGradient(
              colors: [
                Colors.blue,
                Colors.lightBlueAccent,
                Colors.blue,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
