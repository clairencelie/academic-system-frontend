part of 'schedule_pdf_bloc.dart';

abstract class SchedulePdfEvent extends Equatable {
  const SchedulePdfEvent();

  @override
  List<Object> get props => [];
}

class ExportSchedule extends SchedulePdfEvent {
  final String tahunAkademik;
  final String semester;

  const ExportSchedule({
    required this.tahunAkademik,
    required this.semester,
  });

  @override
  List<Object> get props => [
        tahunAkademik,
        semester,
      ];
}

class ExportScheduleMobile extends SchedulePdfEvent {
  final String tahunAkademik;
  final String semester;

  const ExportScheduleMobile({
    required this.tahunAkademik,
    required this.semester,
  });

  @override
  List<Object> get props => [
        tahunAkademik,
        semester,
      ];
}
