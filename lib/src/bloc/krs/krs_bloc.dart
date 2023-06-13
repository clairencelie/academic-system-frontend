import 'package:academic_system/src/repository/krs_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:academic_system/src/model/krs_schedule.dart';

part 'krs_event.dart';
part 'krs_state.dart';

class KrsBloc extends Bloc<KrsEvent, KrsState> {
  final KrsRepository repository;
  KrsBloc({required this.repository}) : super(KrsInitial()) {
    on<GetKrsSchedule>((event, emit) async {
      emit(KrsLoading());

      KrsSchedule? krsSchedule = await repository.getKrsSchedule();

      if (krsSchedule != null) {
        emit(KrsScheduleLoaded(krsSchedule: krsSchedule));
      } else {
        emit(KrsScheduleNotFound());
      }
    });
  }
}
