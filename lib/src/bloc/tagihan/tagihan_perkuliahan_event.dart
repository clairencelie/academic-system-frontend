part of 'tagihan_perkuliahan_bloc.dart';

abstract class TagihanPerkuliahanEvent extends Equatable {
  const TagihanPerkuliahanEvent();

  @override
  List<Object> get props => [];
}

class GetListTagihan extends TagihanPerkuliahanEvent {
  final String nim;

  const GetListTagihan({
    required this.nim,
  });

  @override
  List<Object> get props => [nim];
}
