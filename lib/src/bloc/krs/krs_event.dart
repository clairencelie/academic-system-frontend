part of 'krs_bloc.dart';

abstract class KrsEvent extends Equatable {
  const KrsEvent();

  @override
  List<Object> get props => [];
}

class GetKrsSchedule extends KrsEvent {}
