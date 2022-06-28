import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'date_event.dart';
part 'date_state.dart';

class DateBloc extends Bloc<DateEvent, DateState> {
  DateBloc() : super(DateInitial(DateTime.now())) {
    on<ChangeDateEvent>(_changeDate);
  }

  DateTime get getActiveDate {
    return state.date!;
  }

  void _changeDate(ChangeDateEvent event, Emitter<DateState> emit) {
    emit(ChangeActiveDate(event.date));
  }
}
