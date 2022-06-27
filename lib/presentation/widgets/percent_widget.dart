import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:intl/intl.dart';

class PercentWidget extends StatefulWidget {
  final Function _allBudjet;
  final double budjet;
  final double percentCalc;
  var budjetF = NumberFormat("###.0#");

  PercentWidget(
    this._allBudjet,
    this.budjet,
    this.percentCalc,
  );

  @override
  State<PercentWidget> createState() => _PercentWidgetState();
}

class _PercentWidgetState extends State<PercentWidget> {
  void perdentCalc() {
    int percentResult = widget.percentCalc.toInt();
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
                      widget._allBudjet(context);
                    },
                    icon: const Icon(Icons.edit),
                    label: Text(
                      "${NumberFormat.currency(symbol: "").format(widget.budjet)} sum",
                      style: const TextStyle(
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                "${widget.percentCalc.toStringAsFixed(1)}%",
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
          LinearPercentIndicator(
            alignment: MainAxisAlignment.spaceAround,
            width: 320,
            lineHeight: 5,
            animationDuration: 50,
            percent:
                double.parse(widget.percentCalc.toStringAsFixed(1)) / 100 < 1.0
                    ? double.parse(widget.percentCalc.toStringAsFixed(1)) / 100
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
