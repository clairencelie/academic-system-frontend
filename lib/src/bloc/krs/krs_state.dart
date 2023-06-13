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
