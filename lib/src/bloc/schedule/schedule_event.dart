part of 'schedule_bloc.dart';

abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();

  @override
  List<Object> get props => [];
}

class RequestStudentSchedules extends ScheduleEvent {
  final String id;
  final String idKrs;
  final String day;
  final String tahunAkademik;
  final String semester;

  const RequestStudentSchedules({
    required this.id,
    required this.idKrs,
    required this.day,
    required this.tahunAkademik,
    required this.semester,
  });

  @override
  List<Object> get props => [id, idKrs, day, tahunAkademik, semester];
}

class RequestLecturerSchedules extends ScheduleEvent {
  final String id;
  final String day;
  final String tahunAkademik;
  final String semester;

  const RequestLecturerSchedules({
    required this.id,
    required this.day,
    required this.tahunAkademik,
    required this.semester,
  });

  @override
  List<Object> get props => [id, day, tahunAkademik, semester];
}

class RequestSchedulesByDay extends ScheduleEvent {
  final String day;
  final String tahunAkademik;
  final String semester;

  const RequestSchedulesByDay({
    required this.day,
    required this.tahunAkademik,
    required this.semester,
  });

  @override
  List<Object> get props => [day, tahunAkademik, semester];
}

class RequestAllSchedule extends ScheduleEvent {
  final String tahunAkademik;
  final String semester;

  const RequestAllSchedule({
    required this.tahunAkademik,
    required this.semester,
  });

  @override
  List<Object> get props => [
        tahunAkademik,
        semester,
      ];
}

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
