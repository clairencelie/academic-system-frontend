part of 'krs_bloc.dart';

abstract class KrsEvent extends Equatable {
  const KrsEvent();

  @override
  List<Object> get props => [];
}

class GetKrsSchedule extends KrsEvent {
  final String nim;
  final String semester;

  const GetKrsSchedule({
    required this.nim,
    required this.semester,
  });

  @override
  List<Object> get props => [nim, semester];
}

class GetKrsScheduleForUpdate extends KrsEvent {
  final String nim;
  final String semester;

  const GetKrsScheduleForUpdate({
    required this.nim,
    required this.semester,
  });

  @override
  List<Object> get props => [nim, semester];
}

class GetKrsLengkap extends KrsEvent {
  final String nim;

  const GetKrsLengkap({
    required this.nim,
  });

  @override
  List<Object> get props => [nim];
}

class GetKrsSmtIni extends KrsEvent {
  final String nim;
  final String tahunAkademik;
  final String semester;

  const GetKrsSmtIni({
    required this.nim,
    required this.tahunAkademik,
    required this.semester,
  });

  @override
  List<Object> get props => [
        nim,
        tahunAkademik,
        semester,
      ];
}

class GetAllKrs extends KrsEvent {}

class GetTahunAkademik extends KrsEvent {}

class IsAlreadyFillKrs extends KrsEvent {
  final String nim;
  final String semester;

  const IsAlreadyFillKrs({
    required this.nim,
    required this.semester,
  });

  @override
  List<Object> get props => [nim, semester];
}
