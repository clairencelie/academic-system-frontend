import 'package:academic_system/src/repository/krs_repository.dart';
import 'package:academic_system/src/repository/schedule_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:academic_system/src/model/krs_schedule.dart';

part 'schedule_krs_event.dart';
part 'schedule_krs_state.dart';

class ScheduleKrsBloc extends Bloc<ScheduleKrsEvent, ScheduleKrsState> {
  final KrsRepository krsRepository;
  final ScheduleRepository scheduleRepository;
  ScheduleKrsBloc(
      {required this.krsRepository, required this.scheduleRepository})
      : super(ScheduleKrsInitial()) {
    on<GetScheduleKrs>((event, emit) async {
      emit(ScheduleKrsLoading());

      final KrsSchedule? krsSchedule = await krsRepository.getKrsSchedule();

      if (krsSchedule != null) {
        emit(ScheduleKrsLoaded(krsSchedule: krsSchedule));
      } else {
        emit(ScheduleKrsFailed());
      }
    });

    on<UpdateScheduleKrs>((event, emit) async {
      emit(ScheduleKrsLoading());

      final String message = await scheduleRepository.setJadwalKrs(
          event.tanggalMulai, event.tanggalSelesai);

      if (message == 'set jadwal krs berhasil') {
        emit(const ScheduleKrsUpdateSuccess(
            message: 'Jadwal KRS Berhasil Diset.'));
      } else {
        emit(ScheduleKrsUpdateFailed(message: message));
      }
    });
  }
}
