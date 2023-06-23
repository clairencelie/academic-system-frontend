part of 'schedule_krs_bloc.dart';

abstract class ScheduleKrsEvent extends Equatable {
  const ScheduleKrsEvent();

  @override
  List<Object> get props => [];
}

class GetScheduleKrs extends ScheduleKrsEvent {}

class UpdateScheduleKrs extends ScheduleKrsEvent {
  final String tanggalMulai;
  final String tanggalSelesai;

  const UpdateScheduleKrs({
    required this.tanggalMulai,
    required this.tanggalSelesai,
  });

  @override
  List<Object> get props => [tanggalMulai, tanggalSelesai];
}
