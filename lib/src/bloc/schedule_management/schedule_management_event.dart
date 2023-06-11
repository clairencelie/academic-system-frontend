part of 'schedule_management_bloc.dart';

abstract class ScheduleManagementEvent extends Equatable {
  const ScheduleManagementEvent();

  @override
  List<Object> get props => [];
}

class CreateSchedule extends ScheduleManagementEvent {
  final NewSchedule newSchedule;

  const CreateSchedule({
    required this.newSchedule,
  });

  @override
  List<Object> get props => [newSchedule];
}

class UpdateSchedule extends ScheduleManagementEvent {
  final NewSchedule newSchedule;

  const UpdateSchedule({
    required this.newSchedule,
  });

  @override
  List<Object> get props => [newSchedule];
}

class DeleteSchedule extends ScheduleManagementEvent {
  final List<String> scheduleIds;

  const DeleteSchedule({
    required this.scheduleIds,
  });

  @override
  List<Object> get props => [scheduleIds];
}
