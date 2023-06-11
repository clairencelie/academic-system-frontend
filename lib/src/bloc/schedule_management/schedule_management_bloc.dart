import 'package:academic_system/src/repository/schedule_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:academic_system/src/model/new_schedule.dart';

part 'schedule_management_event.dart';
part 'schedule_management_state.dart';

class ScheduleManagementBloc
    extends Bloc<ScheduleManagementEvent, ScheduleManagementState> {
  final ScheduleRepository repository;
  ScheduleManagementBloc({required this.repository})
      : super(ScheduleManagementInitial()) {
    // Event
    on<CreateSchedule>((event, emit) async {
      emit(ScheduleManagementLoading());

      final String message =
          await repository.createNewSchedule(event.newSchedule);

      if (message == "new schedule succesfully created") {
        emit(NewScheduleCreated(message: message));
      } else if (message == "failed to create new schedule") {
        emit(ScheduleFailed(message: message));
      }
    });

    on<UpdateSchedule>((event, emit) async {
      emit(ScheduleManagementLoading());

      final String message = await repository.updateSchedule(event.newSchedule);

      if (message == "schedule succesfully updated") {
        emit(ScheduleUpdated(message: message));
      } else if (message == "failed to update schedule") {
        emit(ScheduleUpdateFailed(message: message));
      }
    });

    on<DeleteSchedule>((event, emit) async {
      emit(ScheduleManagementLoading());

      String message = await repository.deleteSchedule(event.scheduleIds);

      if (message == "schedule removed") {
        emit(ScheduleDeleted(message: message));
      } else if (message == "failed to remove schedule") {
        emit(ScheduleDeleteFailed(message: message));
      }
    });
  }
}
