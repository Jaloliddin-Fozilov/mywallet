import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mywallet/data/models/expense.dart';

part 'date_state.dart';

class DateCubit extends Cubit<DateState> {
  DateCubit() : super(DateInitial(DateTime.now()));
  DateTime get getActiveDate {
    return state.date!;
  }

  void changeDate(DateTime date) {
    emit(ChangeActiveDate(date));
  }
}
