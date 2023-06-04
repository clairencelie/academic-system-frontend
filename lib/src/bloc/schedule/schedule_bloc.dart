import 'package:academic_system/src/model/schedule.dart';
import 'package:academic_system/src/repository/schedule_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ScheduleRepository repository;

  ScheduleBloc({required this.repository}) : super(ScheduleInitial()) {
    on<RequestStudentSchedules>((event, emit) async {
      emit(RequestingSchedule());

      try {
        List<Schedule> schedules =
            await repository.getStudentSchedules(id: event.id, day: event.day);

        if (schedules.isNotEmpty) {
          emit(ScheduleLoaded(schedules: schedules));
        } else {
          emit(ScheduleEmpty());
        }
      } on Exception catch (e) {
        emit(ScheduleRequestFailed(message: e.toString()));
      }
    });

    on<RequestLecturerSchedules>((event, emit) async {
      emit(RequestingSchedule());

      try {
        List<Schedule> schedules =
            await repository.getLecturerSchedules(id: event.id, day: event.day);

        if (schedules.isNotEmpty) {
          emit(ScheduleLoaded(schedules: schedules));
        } else {
          emit(ScheduleEmpty());
        }
      } on Exception catch (e) {
        emit(ScheduleRequestFailed(message: e.toString()));
      }
    });

    on<RequestSchedulesByDay>((event, emit) async {
      emit(RequestingSchedule());

      try {
        List<Schedule> schedules =
            await repository.getSchedulesByDay(day: event.day);

        if (schedules.isNotEmpty) {
          emit(ScheduleLoaded(schedules: schedules));
        } else {
          emit(ScheduleEmpty());
        }
      } on Exception catch (e) {
        emit(ScheduleRequestFailed(message: e.toString()));
      }
    });

    on<RequestAllSchedule>((event, emit) async {
      emit(RequestingSchedule());

      try {
        List<Schedule> schedules = await repository.getAllSchedule();

        if (schedules.isNotEmpty) {
          emit(ScheduleLoaded(schedules: schedules));
        } else {
          emit(ScheduleEmpty());
        }
      } on Exception catch (e) {
        emit(ScheduleRequestFailed(message: e.toString()));
      }
    });
  }
}
