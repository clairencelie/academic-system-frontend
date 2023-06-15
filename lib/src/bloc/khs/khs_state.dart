part of 'khs_bloc.dart';

abstract class KhsState extends Equatable {
  const KhsState();

  @override
  List<Object> get props => [];
}

class KhsInitial extends KhsState {}

class KhsLoading extends KhsState {}

class KhsLoaded extends KhsState {}

class KhsFailed extends KhsState {}

class TranskripLoaded extends KhsState {
  final TranksripLengkap transkripLengkap;

  const TranskripLoaded({
    required this.transkripLengkap,
  });

  @override
  List<Object> get props => [transkripLengkap];
}

class TranskripFailed extends KhsState {}
