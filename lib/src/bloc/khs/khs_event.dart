part of 'khs_bloc.dart';

abstract class KhsEvent extends Equatable {
  const KhsEvent();

  @override
  List<Object> get props => [];
}

class GetTranskripEvent extends KhsEvent {
  final String nim;

  const GetTranskripEvent({
    required this.nim,
  });

  @override
  List<Object> get props => [nim];
}
