part of 'schedule_bloc.dart';

abstract class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object> get props => [];
}

class ScheduleInitial extends ScheduleState {}

class RequestingSchedule extends ScheduleState {}

class ScheduleLoaded extends ScheduleState {
  final List<Schedule> schedules;

  const ScheduleLoaded({
    required this.schedules,
  });

  @override
  List<Object> get props => [schedules];
}

class ScheduleEmpty extends ScheduleState {}

class ScheduleRequestFailed extends ScheduleState {
  final String message;

  const ScheduleRequestFailed({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
