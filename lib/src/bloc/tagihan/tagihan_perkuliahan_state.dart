part of 'tagihan_perkuliahan_bloc.dart';

abstract class TagihanPerkuliahanState extends Equatable {
  const TagihanPerkuliahanState();

  @override
  List<Object> get props => [];
}

class TagihanPerkuliahanInitial extends TagihanPerkuliahanState {}

class TagihanPerkuliahanLoading extends TagihanPerkuliahanState {}

class TagihanPerkuliahanLoaded extends TagihanPerkuliahanState {
  final List<TagihanPerkuliahan> listTagihan;

  const TagihanPerkuliahanLoaded({
    required this.listTagihan,
  });

  @override
  List<Object> get props => [listTagihan];
}

class TagihanPerkuliahanNotFound extends TagihanPerkuliahanState {}
