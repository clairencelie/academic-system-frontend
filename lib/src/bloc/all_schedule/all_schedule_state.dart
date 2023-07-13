part of 'all_schedule_bloc.dart';

abstract class AllScheduleState extends Equatable {
  const AllScheduleState();

  @override
  List<Object> get props => [];
}

class AllScheduleInitial extends AllScheduleState {}

class AllScheduleLoading extends AllScheduleState {}

class AllScheduleFound extends AllScheduleState {
  final List<Schedule> schedules;

  const AllScheduleFound({
    required this.schedules,
  });

  @override
  List<Object> get props => [schedules];
}

class AllScheduleEmpty extends AllScheduleState {}

class AllScheduleRequestFailed extends AllScheduleState {
  final String message;

  const AllScheduleRequestFailed({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
