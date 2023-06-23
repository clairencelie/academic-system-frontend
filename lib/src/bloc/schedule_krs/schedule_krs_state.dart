part of 'schedule_krs_bloc.dart';

abstract class ScheduleKrsState extends Equatable {
  const ScheduleKrsState();

  @override
  List<Object> get props => [];
}

class ScheduleKrsInitial extends ScheduleKrsState {}

class ScheduleKrsLoading extends ScheduleKrsState {}

class ScheduleKrsLoaded extends ScheduleKrsState {
  final KrsSchedule krsSchedule;

  const ScheduleKrsLoaded({
    required this.krsSchedule,
  });

  @override
  List<Object> get props => [krsSchedule];
}

class ScheduleKrsFailed extends ScheduleKrsState {}

class ScheduleKrsUpdateSuccess extends ScheduleKrsState {
  final String message;

  const ScheduleKrsUpdateSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class ScheduleKrsUpdateFailed extends ScheduleKrsState {
  final String message;

  const ScheduleKrsUpdateFailed({required this.message});

  @override
  List<Object> get props => [message];
}
