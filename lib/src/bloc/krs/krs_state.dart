part of 'krs_bloc.dart';

abstract class KrsState extends Equatable {
  const KrsState();

  @override
  List<Object> get props => [];
}

class KrsInitial extends KrsState {}

class KrsLoading extends KrsState {}

class KrsScheduleLoaded extends KrsState {
  final KrsSchedule krsSchedule;

  const KrsScheduleLoaded({
    required this.krsSchedule,
  });

  @override
  List<Object> get props => [krsSchedule];
}

class KrsScheduleNotFound extends KrsState {}

class AlreadyFillKrs extends KrsState {
  final String message;

  const AlreadyFillKrs({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class KrsFound extends KrsState {
  final List<KartuRencanaStudiLengkap> krsLengkap;

  const KrsFound({required this.krsLengkap});

  @override
  List<Object> get props => [krsLengkap];
}

class KrsNotFound extends KrsState {}

class KrsSmtIniFound extends KrsState {
  final KartuRencanaStudiLengkap krsLengkap;

  const KrsSmtIniFound({required this.krsLengkap});

  @override
  List<Object> get props => [krsLengkap];
}

class KrsSmtIniNotFound extends KrsState {}
