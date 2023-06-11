part of 'schedule_management_bloc.dart';

abstract class ScheduleManagementState extends Equatable {
  const ScheduleManagementState();

  @override
  List<Object> get props => [];
}

class ScheduleManagementInitial extends ScheduleManagementState {}

class ScheduleManagementLoading extends ScheduleManagementState {}

// =======================================================
// State for create schedule
// =======================================================
class NewScheduleCreated extends ScheduleManagementState {
  final String message;

  const NewScheduleCreated({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class ScheduleFailed extends ScheduleManagementState {
  final String message;

  const ScheduleFailed({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
// =======================================================

// =======================================================
// State for update schedule
// =======================================================
class ScheduleUpdated extends ScheduleManagementState {
  final String message;

  const ScheduleUpdated({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class ScheduleUpdateFailed extends ScheduleManagementState {
  final String message;

  const ScheduleUpdateFailed({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
// =======================================================

class ScheduleDeleted extends ScheduleManagementState {
  final String message;

  const ScheduleDeleted({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class ScheduleDeleteFailed extends ScheduleManagementState {
  final String message;

  const ScheduleDeleteFailed({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
