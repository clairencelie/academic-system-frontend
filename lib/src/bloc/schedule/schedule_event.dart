part of 'schedule_bloc.dart';

abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();

  @override
  List<Object> get props => [];
}

class RequestStudentSchedules extends ScheduleEvent {
  final String id;
  final String day;

  const RequestStudentSchedules({
    required this.id,
    required this.day,
  });

  @override
  List<Object> get props => [id, day];
}

class RequestLecturerSchedules extends ScheduleEvent {
  final String id;
  final String day;

  const RequestLecturerSchedules({
    required this.id,
    required this.day,
  });

  @override
  List<Object> get props => [id, day];
}

class RequestSchedulesByDay extends ScheduleEvent {
  final String day;

  const RequestSchedulesByDay({
    required this.day,
  });

  @override
  List<Object> get props => [day];
}

class RequestAllSchedule extends ScheduleEvent {}

class SearchSchedule extends ScheduleEvent {
  final String keyword;
  final List<Schedule> schedules;

  const SearchSchedule({
    required this.keyword,
    required this.schedules,
  });

  @override
  List<Object> get props => [keyword, schedules];
}
