import 'package:academic_system/src/model/schedule.dart';
import 'package:academic_system/src/repository/schedule_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'all_schedule_event.dart';
part 'all_schedule_state.dart';

class AllScheduleBloc extends Bloc<AllScheduleEvent, AllScheduleState> {
  final ScheduleRepository repository;
  AllScheduleBloc({required this.repository}) : super(AllScheduleInitial()) {
    on<GetAllSchedule>((event, emit) async {
      emit(AllScheduleLoading());

      try {
        final List<Schedule> schedules = await repository.getAllSchedule(
          event.tahunAkademik,
          event.semester,
        );

        if (schedules.isNotEmpty) {
          emit(AllScheduleFound(schedules: schedules));
        } else {
          emit(AllScheduleEmpty());
        }
      } on Exception catch (_) {
        emit(const AllScheduleRequestFailed(
            message: 'Error, gagal mendapatkan data jadwal'));
      }
    });
  }
}
