part of 'all_schedule_bloc.dart';

abstract class AllScheduleEvent extends Equatable {
  const AllScheduleEvent();

  @override
  List<Object> get props => [];
}

class GetAllSchedule extends AllScheduleEvent {
  final String tahunAkademik;
  final String semester;

  const GetAllSchedule({
    required this.tahunAkademik,
    required this.semester,
  });

  @override
  List<Object> get props => [
        tahunAkademik,
        semester,
      ];
}
