import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import '../../logic/date/date_bloc.dart';

class ActiveDate extends StatefulWidget {
  const ActiveDate({Key? key}) : super(key: key);
  @override
  State<ActiveDate> createState() => _ActiveDateState();
}

class _ActiveDateState extends State<ActiveDate> {
  bool _init = false;

  DateTime selectedMonth = DateTime.now();

  @override
  void didChangeDependencies() {
    if (!_init) {
      context.read<DateBloc>().add(ChangeDateEvent(selectedMonth));
    }
    _init = true;
    super.didChangeDependencies();
  }

  void selectDate(BuildContext context) {
    showMonthPicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then(
      (selected) {
        if (selected != null) {
          setState(
            () {
              selectedMonth = selected;
              context.read<DateBloc>().add(ChangeDateEvent(selectedMonth));
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              selectDate(context);
            },
            child: BlocBuilder<DateBloc, DateState>(
              builder: (context, state) {
                if (state is ChangeActiveDate) {
                  return Text(
                    DateFormat("MMMM, yyyy")
                        .format(context.read<DateBloc>().getActiveDate),
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 18),
                  );
                }
                return Text(
                  DateFormat("MMMM, yyyy")
                      .format(context.read<DateBloc>().getActiveDate),
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 18),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
